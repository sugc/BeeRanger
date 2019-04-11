//
//  NewWorkManager.h
//  BeeRanger
//
//  Created by sugc on 2019/4/2.
//  Copyright © 2019 sugc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, TaskStatus) {
    TaskStatusRequest = 0,
    TaskStatusWaitingForReply = 1,
    TaskStatusBegin = 2,
    TaskStatusArrived = 3,
    TaskStatusComplete = 4,
    TaskStatusNone = 5
};



@protocol NetWorkDelegate <NSObject>

- (void)updateStatus:(TaskStatus)status isIntask:(BOOL)isInTask msg:(NSDictionary *)msg;


@end

@interface NewWorkManager : NSObject

@property (nonatomic, assign) BOOL isInTask;   //是否正在帮助别人

@property (nonatomic, weak) id<NetWorkDelegate> delegate;
    
+ (instancetype)shareInstance;

- (void)updateHelpMsg;

@end
