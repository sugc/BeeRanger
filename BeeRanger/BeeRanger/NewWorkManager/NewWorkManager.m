//
//  NewWorkManager.m
//  BeeRanger
//
//  Created by sugc on 2019/4/2.
//  Copyright © 2019 sugc. All rights reserved.
//

#import "NewWorkManager.h"
#import <AFNetworking.h>

@interface NewWorkManager()
    
@property (nonatomic, strong) NSTimer *timer;
    

@end


@implementation NewWorkManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static NewWorkManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[NewWorkManager alloc] init];
    });
    return instance;
}
    
- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化
        
    }
    return self;
}
    
//启动Timer定时请求
- (void)starRequest {
    if (_timer) {
        [_timer invalidate];
    }
    
    _timer = [NSTimer timerWithTimeInterval:4 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self sendRequest];
    }];
    [_timer fire];
}
    
- (void)sendRequest {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            //解析数据
        }
    }];
    [dataTask resume];
}
    
    
- (void)stopRequst {
    if (_timer) {
        [_timer invalidate];
    }
}

//需要帮助时上传个人信息
- (void)updateHelpMsg {
    
    //设置参数
    //
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
//    request.HTTPBody
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            //解析数据
        }
    }];
    [dataTask resume];
    
}
    
@end
