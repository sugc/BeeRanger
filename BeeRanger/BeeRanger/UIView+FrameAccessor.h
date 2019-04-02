//
//  UIView+FrameAccessor.h
//  MTShape
//
//  Created by ZhangXiaoJun on 14-8-8.
//  Copyright (c) 2014年 JoyChiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameAccessor)

// Frame
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

// Frame Origin
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// Frame Size
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

// Frame Borders
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

// Middle Point
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;


/*
 * Label上下居中
 * return:  一行的高度
 * by hyk
 */
+ (void)setSubviewCenterOnVertical:(UIView *)subView AtX:(CGFloat)xStart superView:(UIView *)superView;

/*
 * UIView左右居中
 * return:  一行的高度
 * by hyk
 */
+ (void)setSubviewCenterOnHorizontal:(UIView *)subView AtY:(CGFloat)yStart superView:(UIView *)superView;

/*
 * UIView上下左右居中
 * return:  一行的高度
 * by hyk
 */
+ (void)setSubviewOnCenter:(UIView *)subView superView:(UIView *)superView;

@end
