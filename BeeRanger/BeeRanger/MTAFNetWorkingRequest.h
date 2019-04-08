//
//  MTAFNetWorkingRequest.h
//  BeautyPlus
//
//  Created by zzx on 17/1/20.
//  Copyright © 2017年 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

typedef NS_ENUM(NSInteger, RequestType) {
    GETRequest = 0,
    POSTRequest
};

@interface MTAFNetWorkingRequest : NSObject


/**
 MTAF 单例

 @return 单例
 */
+ (AFHTTPSessionManager *)httpManager ;


/**
 请求服务端数据

 @param type        请求类型GET，POST
 @param url         请求URL
 @param parameters  请求参数
 @param success     请求成功
 @param failure     请求失败
 */
+ (void)requestWithType:(RequestType)type
                    url:(NSString *)url
                 header:(NSDictionary *)header
             parameters:(NSDictionary *)parameters
         successHandler:(void(^)(NSDictionary *resultDictionary))success
         failureHandler:(void(^)(NSURLResponse *response,NSError *error))failure;

+ (void)requestHeaderSetting:(AFHTTPSessionManager *)manager
                      header:(NSDictionary *)header;


@end
