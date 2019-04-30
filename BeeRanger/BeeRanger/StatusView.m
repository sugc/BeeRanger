//
//  StatusView.m
//  BeeRanger
//
//  Created by sugc on 2019/4/7.
//  Copyright © 2019 sugc. All rights reserved.
//

#import "StatusView.h"
#import "UIView+FrameAccessor.h"
#import "UtilsDef.h"
#import "NewWorkManager/NewWorkManager.h"
#import "NewWorkManager/LocationManager.h"

@interface StatusView ()

@property (nonatomic, strong) UIButton *restButton;

@property (nonatomic, strong) UIButton *shrinkBtn;

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *contentView;


@end

@implementation StatusView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point) && view.alpha > 0) {
            CGPoint newPoint = [self convertPoint:point toView:view];
            return [view hitTest:newPoint withEvent:event];
        }
    }
    return nil;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _status = -1;
        [self layout];
        [self changeToStatus:TaskStatusRequest msg:nil animate:NO];
    }
    
    return self;
}

- (void)layout {
    
    
    _restButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 40, 40)];
    [_restButton setBackgroundImage:[UIImage imageNamed:@"btn_map_reset"] forState:UIControlStateNormal];
    [_restButton addTarget:self action:@selector(resetMap) forControlEvents:UIControlEventTouchUpInside];
    _restButton.layer.cornerRadius = 20;
    _restButton.layer.masksToBounds = YES;
    _restButton.bottom = ScreenHeight - 200;
    [self addSubview:_restButton];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.frame = CGRectMake(10, self.height, self.width - 20, 40);
    [self addSubview:_contentView];
    
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.image = [UIImage imageNamed:@"img_phone_call"];
    _rightImageView.width = 47;
    _rightImageView.height = 12;
    _rightImageView.centerY = _leftImageView.centerY;
    _rightImageView.right = _contentView.width - 30;
    _rightImageView.hidden = NO;
    [_contentView addSubview:_rightImageView];
    
    _shrinkBtn = [[UIButton alloc] initWithFrame:CGRectMake(_contentView.width - 20 - 10, 10, 20, 10)];
    [_shrinkBtn setBackgroundImage:[UIImage imageNamed:@"up_down_arrow"] forState:UIControlStateNormal];
    
    [_contentView addSubview:_shrinkBtn];
    
    _imageView = [[UIImageView alloc] init];
    [_contentView addSubview:_imageView];
    
    _leftImageView = [[UIImageView alloc] init];
    [_contentView addSubview:_leftImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 1;
    [_contentView addSubview:_titleLabel];
    
    _button1 = [[UIButton alloc] init];
    _button1.layer.cornerRadius = 5;
    _button1.layer.masksToBounds = YES;
    _button1.titleLabel.textColor = [UIColor whiteColor];
    [_contentView addSubview:_button1];
    [_button1 addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _button2 = [[UIButton alloc] init];
    _button2.layer.cornerRadius = 5;
    _button2.layer.masksToBounds = YES;
    _button2.titleLabel.textColor = [UIColor whiteColor];
    
    
    _centerImageView = [[UIImageView alloc] init];
    [self addSubview:_centerImageView];
    _centerImageView.hidden = YES;
    _centerImageView.image = [UIImage imageNamed:@"status_none_centerImage"];
    CGFloat imgW = ScreenWidth / 3.0;
    CGFloat imgH = imgW / _centerImageView.image.size.width * _centerImageView.image.size.height;
    _centerImageView.size = CGSizeMake(imgW, imgH);
    _centerImageView.centerX = self.width / 2.0;
    _centerImageView.centerY = self.height / 2.0;
}

- (void)changeToStatus:(TaskStatus)staus msg:(NSDictionary *)msg animate:(BOOL)animate {
    
    if (staus <= self.status) {
        return;
    }
    
    self.status = staus;
    
    if (staus == TaskStatusComplete) {
        return;
    }
    
    
    if (!animate) {
        [self refreshWithStatus:staus msg:msg];
        _contentView.bottom = _contentView.bottom = self.height - 5 - 10;
        _restButton.alpha = 1.0;
        CGFloat space = 200 > (_contentView.height + 15) ? 200 : (_contentView.height + 15);
        _restButton.bottom = self.height - space - 15;
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.top = self.height;
        self.restButton.alpha = 0.0;
    }completion:^(BOOL finished) {
        [self refreshWithStatus:staus msg:msg];
        CGFloat space = 200 > (self.contentView.height + 15) ? 200 : (self.contentView.height + 15);
        self.restButton.bottom = self.height - space - 15;
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.bottom = self.height - 5 - 10;
            self.restButton.alpha = 1.0;
        }];
    }];
    
}


- (void)refreshWithStatus:(TaskStatus)status msg:(NSDictionary *)msg {
    //刷新状态
    _centerImageView.hidden = YES;
    _button1.size = CGSizeMake(120, 44);
    _button1.centerX = _contentView.width / 2.0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _imageView.hidden = YES;
    _leftImageView.hidden = YES;
    _rightImageView.hidden = YES;
    
    if (status == TaskStatusRequest) {
        _centerImageView.hidden = NO;
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"您的電池電量過低!" attributes:@{
                                                                                                         NSFontAttributeName :[UIFont systemFontOfSize:18]
                                                      }];
        [_titleLabel sizeToFit];
        _titleLabel.top = 40;
        _titleLabel.centerX = _contentView.width / 2.0;
        
        _button1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _button1.top = _titleLabel.bottom + 30;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_search_for_help"] forState:UIControlStateNormal];
        [_button1 setTitle:@"寻求救援" forState:UIControlStateNormal];
        
        _contentView.height = _button1.bottom + 20;
        _contentView.bottom = self.height - 5 - 10;
        
         _centerImageView.centerY = (self.height - _contentView.height )/ 2.0;
    }
    
    if (status == TaskStatusWaitingForReply) {
        //等待应答
        _imageView.image = [UIImage imageNamed:@"status_in_help"];
        _imageView.width = 108;
        _imageView.height = 38;
        _imageView.centerX = _contentView.width / 2.0;
        _imageView.top = 40;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.hidden = NO;
        
        _rightImageView.hidden = NO;
        _rightImageView.centerY = _imageView.centerY;
        
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"正在等待救援" attributes:@{
                                                                                                                           NSFontAttributeName :[UIFont systemFontOfSize:18]
                                                                                                                           }];
        [_titleLabel sizeToFit];
        _titleLabel.top = _imageView.bottom + 15;
        _titleLabel.centerX = _contentView.width / 2.0;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_in_help"] forState:UIControlStateNormal];
        [_button1 setTitle:@"取消求救" forState:UIControlStateNormal];
        _button1.top = _titleLabel.bottom + 20;
        _contentView.height = _button1.bottom + 20;
    }
    
    if (status == TaskStatusBegin) {
        //任务开始
        _imageView.image = [UIImage imageNamed:@"status_in_help"];
        _imageView.width = 108;
        _imageView.height = 38;
        _imageView.centerX = _contentView.width / 2.0;
        _imageView.top = 40;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.hidden = NO;
        
        _rightImageView.hidden = NO;
        _rightImageView.centerY = _imageView.centerY;
        
        NSString *str = @"騎士L72.628正在前往救援\n大約需要 5 分鐘抵達";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{
                                                                                                                            NSFontAttributeName :[UIFont systemFontOfSize:18]
                                                                                                                            }];
        NSRange range = [str rangeOfString:@"大約需要 5 分鐘抵達"];
        [attrStr setAttributes:@{
                                 NSFontAttributeName :[UIFont systemFontOfSize:16],
                                 NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                 } range:range];
        
        NSRange range2 = [str rangeOfString:@"L72.628"];
        [attrStr setAttributes:@{
                                 NSFontAttributeName :[UIFont systemFontOfSize:16],
                                 NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:120 / 255.0 blue:0 alpha:1]
                                 } range:range2];
        
        NSRange range1 = [str rangeOfString:@"5"];
        [attrStr setAttributes:@{
                                 NSFontAttributeName :[UIFont systemFontOfSize:16],
                                 NSForegroundColorAttributeName : [UIColor colorWithRed:69/255.0 green:170 / 255.0 blue:167/255.0 alpha:1]
                                 } range:range1];
        
        _titleLabel.attributedText = attrStr;
        [_titleLabel sizeToFit];
        _titleLabel.top = _imageView.bottom + 15;
        _titleLabel.centerX = _contentView.width / 2.0;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_in_help"] forState:UIControlStateNormal];
        [_button1 setTitle:@"取消求救" forState:UIControlStateNormal];
        _button1.top = _titleLabel.bottom + 20;
        _contentView.height = _button1.bottom + 20;
    }
    
    //到达
    if (status == TaskStatusArrived) {
        _imageView.image = [UIImage imageNamed:@"img_arrive"];
        _imageView.width = 38;
        _imageView.height = 38;
        _imageView.centerX = _contentView.width / 2.0;
        _imageView.top = 40;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.hidden = NO;
        
        _rightImageView.hidden = NO;
        _rightImageView.centerY = _imageView.centerY;
        
        NSString *str = @"騎士L72.628已到達";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{
                                                                                                                NSFontAttributeName :[UIFont systemFontOfSize:18]
                                                                                                                }];
        NSRange range = [str rangeOfString:@"L72.628"];
        [attrStr setAttributes:@{
                                 NSFontAttributeName :[UIFont systemFontOfSize:16],
                                 NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:120 / 255.0 blue:0 alpha:1]
                                 } range:range];
        _titleLabel.attributedText = attrStr;
        [_titleLabel sizeToFit];
        _titleLabel.top = _imageView.bottom + 15;
        _titleLabel.centerX = _contentView.width / 2.0;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_in_help"] forState:UIControlStateNormal];
        [_button1 setTitle:@"取消求救" forState:UIControlStateNormal];
        _button1.top = _titleLabel.bottom + 20;
        _contentView.height = _button1.bottom + 20;
    }
    
    //完成
    if (status == TaskStatusCompleteAndShare) {
        _imageView.image = [UIImage imageNamed:@"img_battery"];
        _imageView.width = 35;
        _imageView.height = 61;
        _imageView.centerX = _contentView.width / 2.0;
        _imageView.top = 40;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.hidden = NO;
        
        _rightImageView.hidden = NO;
        _rightImageView.centerY = _imageView.centerY;
        
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"恭喜您完成交換!" attributes:@{
                                                                                                                           NSFontAttributeName :[UIFont systemFontOfSize:18]
                                                                                                                           }];
        [_titleLabel sizeToFit];
        _titleLabel.top = _imageView.bottom + 15;
        _titleLabel.centerX = _contentView.width / 2.0;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_in_help"] forState:UIControlStateNormal];
        [_button1 setTitle:@"分享" forState:UIControlStateNormal];
        _button1.top = _titleLabel.bottom + 20;
        _contentView.height = _button1.bottom + 20;
    }
    
}

- (void)resetMap {
     [[LocationManager shareInstance] resetMapViewToCenter];
}

- (void)clickBtn {
    if (_forceGoNext) {
        [[NewWorkManager shareInstance] goNextForce];
        
    }else {
        [[NewWorkManager shareInstance] updateHelpMsg];
    }
}



@end
