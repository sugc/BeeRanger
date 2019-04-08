//
//  MTAFNetWorkingRequest.m
//  BeautyPlus
//
//  Created by zzx on 17/1/20.
//  Copyright © 2017年 美图网. All rights reserved.
//

#import "MTAFNetWorkingRequest.h"

static AFHTTPSessionManager *kManager;

@implementation MTAFNetWorkingRequest

+ (AFHTTPSessionManager *)httpManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化请求管理类
        kManager = [AFHTTPSessionManager manager];
        kManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        kManager.requestSerializer.timeoutInterval = 30.0;
    });
    return kManager;
    
}

+ (void)requestWithType:(RequestType)type
                    url:(NSString *)url
                 header:(NSDictionary *)header
             parameters:(NSDictionary *)parameters
         successHandler:(void (^)(NSDictionary *))success
         failureHandler:(void (^)(NSURLResponse *, NSError *))failure{
    AFHTTPSessionManager *HTTPManager = [MTAFNetWorkingRequest httpManager];
    
    if (header) {
        // Bugfix: 解决多线程设置requestSerializer导致的crash
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [MTAFNetWorkingRequest requestHeaderSetting:HTTPManager header:header];
        });
    }
    
    if (type == GETRequest) {
        
        [HTTPManager GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = nil;
            if ([responseObject isKindOfClass:[NSData class]]) {
                dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                dic = responseObject;
            }
            if (success) {
                success(dic);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task.response,error);
            }
        }];
        
    } else if (type == POSTRequest) {
     
        
        [HTTPManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = nil;
            if ([responseObject isKindOfClass:[NSData class]]) {
                dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                dic = responseObject;
            }
            if (success) {
                success(dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
                failure(task.response,error);
            }
        }];
        
    } else {
        
    }

}


//解析请求header
+ (void)requestHeaderSetting:(AFHTTPSessionManager *)manager
                      header:(NSDictionary *)header {
    
    if (header != nil) {
        for (id httpHeaderField in header.allKeys) {
            id value = header[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];//这种情况设置就成功了。。
            } else {
                NSLog(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
            }
        }
    }
}


@end
