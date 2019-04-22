//
//  StatusView.h
//  BeeRanger
//
//  Created by sugc on 2019/4/7.
//  Copyright © 2019 sugc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWorkManager/NewWorkManager.h"

@interface StatusView : UIView

@property (nonatomic, assign) TaskStatus status;

- (void)changeToStatus:(TaskStatus)staus msg:(NSDictionary *)msg animate:(BOOL)animate;

@end
