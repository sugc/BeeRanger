//
//  NewWorkManager.m
//  BeeRanger
//
//  Created by sugc on 2019/4/2.
//  Copyright © 2019 sugc. All rights reserved.
//

#import "NewWorkManager.h"
#import <AFNetworking.h>
#import <AdSupport/ASIdentifierManager.h>
#import "MTAFNetWorkingRequest.h"
#import "LocationManager.h"

//static NSString *const host = @"http://192.168.199.171:5000";
static NSString *const host = @"http://192.168.0.12:5000";


@interface NewWorkManager()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) BOOL isAskingHelp; //是否正在寻求帮助


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
        NSString *idfa = [NewWorkManager idfa];
        _userName = [@"L." stringByAppendingString:[idfa substringToIndex:4]];
        [self starRequest];
    }
    return self;
}

//启动Timer定时请求
- (void)starRequest {
    if (_timer) {
        [_timer invalidate];
    }
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:4 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self sendRequest];
    }];
}

- (void)sendRequest {
    
    
    CLLocation *location = [LocationManager shareInstance].location;
    NSDictionary *param = @{@"userName":_userName,
                            @"lng":@(location.coordinate.longitude),
                            @"lat":@(location.coordinate.latitude)
                            };
    
    NSString *url = [host stringByAppendingPathComponent:@"gethelpmsg"];
    [MTAFNetWorkingRequest requestWithType:POSTRequest
                                       url:url
                                    header:nil
                                parameters:param
                            successHandler:^(NSDictionary *resultDictionary) {
                                NSNumber *error = resultDictionary[@"error"];
                                if (!error || [error integerValue] != 0) {
                                    
                                    return;
                                }
                                
                                if ([self.delegate respondsToSelector:@selector(updateStatus:isIntask:msg:)]) {
                                    [self.delegate updateStatus:TaskStatusNone isIntask:YES msg:resultDictionary];
                                }
                            } failureHandler:^(NSURLResponse *response, NSError *error) {
                                NSLog(@"Error: %@", error);
                            }];
}


- (void)stopRequst {
    if (_timer) {
        [_timer invalidate];
    }
}

//需要帮助时上传个人信息
- (void)updateHelpMsg {
    
    //设置参数
//    if (_isAskingHelp || _isInTask) {
//        return;
//    }
    
    _isAskingHelp = YES;
    CLLocation *location = [LocationManager shareInstance].location;
    NSDictionary *param = @{@"userName":_userName,
                            @"lng":@(location.coordinate.longitude),
                            @"lat":@(location.coordinate.latitude),
                            @"status":@(TaskStatusWaitingForReply)
                            };
    
    NSString *url = [host stringByAppendingPathComponent:@"updatehtlpmsg"];
    [MTAFNetWorkingRequest requestWithType:POSTRequest
                                       url:url
                                    header:nil
                                parameters:param
                            successHandler:^(NSDictionary *resultDictionary) {
                                if ([self.delegate respondsToSelector:@selector(updateStatus:isIntask:msg:)]) {
                                    
                                    [self.delegate updateStatus:TaskStatusWaitingForReply isIntask:NO msg:@{@"status":@(TaskStatusWaitingForReply)}];
                                }
                                
                            } failureHandler:^(NSURLResponse *response, NSError *error) {
                                NSLog(@"Error: %@", error);
                                self.isAskingHelp = NO;
                                
                                
                            }];
    
}

- (void)goNextForce {
    if ([_delegate respondsToSelector:@selector(goNextForce)]) {
        [_delegate goNextForce];
    }
}


+ (NSString *)idfa {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

@end
