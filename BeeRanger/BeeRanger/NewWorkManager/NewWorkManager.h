//
//  NewWorkManager.h
//  BeeRanger
//
//  Created by sugc on 2019/4/2.
//  Copyright © 2019 sugc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, TaskStatus) {
    TaskStatusRequest = 0,
    TaskStatusBegin = 1,
    TaskStatusArrived = 2,
    TaskStatusComplete = 3,
    TaskStatusNone = 4
};


@protocol NetWorkDelegate <NSObject>

- (void)updateStatus:(TaskStatus)status isIntask:(BOOL)isInTask msg:(NSDictionary *)msg;

@end

@interface NewWorkManager : NSObject

@property (nonatomic, assign) BOOL isInTask;   //是否正在帮助别人

@property (nonatomic, weak) id<NetWorkDelegate> delegate;
    
+ (instancetype)shareInstance;

@end
