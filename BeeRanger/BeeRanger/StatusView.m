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

@interface StatusView ()

@property (nonatomic, strong) UIButton *restButton;

@property (nonatomic, strong) UIButton *shrinkBtn;

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation StatusView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point) && view.alpha > 0) {
            return view;
        }
    }
    return nil;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
        [self refreshWithStatus:TaskStatusComplete msg:nil];
    }
    
    return self;
}

- (void)layout {
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.frame = CGRectMake(10, self.height, self.width - 20, 40);
    [self addSubview:_contentView];
    
    _shrinkBtn = [[UIButton alloc] initWithFrame:CGRectMake(_contentView.width - 20 - 10, 10, 20, 10)];
    [_shrinkBtn setBackgroundImage:[UIImage imageNamed:@"up_down_arrow"] forState:UIControlStateNormal];
    
    [_contentView addSubview:_shrinkBtn];
    
    _imageView = [[UIImageView alloc] init];
    [_contentView addSubview:_imageView];
    
    _leftImageView = [[UIImageView alloc] init];
    [_contentView addSubview:_leftImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    [_contentView addSubview:_titleLabel];
    
    _button1 = [[UIButton alloc] init];
    _button1.layer.cornerRadius = 5;
    _button1.layer.masksToBounds = YES;
    _button1.titleLabel.textColor = [UIColor whiteColor];
    [_contentView addSubview:_button1];
    
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

- (void)refreshWithStatus:(TaskStatus)status msg:(NSDictionary *)msg {
    //刷新状态
    _centerImageView.hidden = YES;
    _button1.size = CGSizeMake(120, 44);
    _button1.centerX = _contentView.width / 2.0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (status == TaskStatusNone) {
        _centerImageView.hidden = NO;
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"您的电池电量过低!" attributes:@{
                                                                                                         NSFontAttributeName :[UIFont systemFontOfSize:16]
                                                      }];
        _imageView.hidden = YES;
        _leftImageView.hidden = YES;
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
    
    if (status == TaskStatusBegin) {
        //任务开始
        _imageView.image = [UIImage imageNamed:@"status_in_help"];
        _imageView.width = 108;
        _imageView.height = 38;
        _imageView.centerX = _contentView.width / 2.0;
        _imageView.top = 40;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"骑士L72.628正在前往救援\n大约需要5分钟到达" attributes:@{
                                                                                                          NSFontAttributeName :[UIFont systemFontOfSize:16]
                                                                                                          }];
        [_titleLabel sizeToFit];
        _titleLabel.top = _imageView.bottom + 15;
        _titleLabel.centerX = _contentView.width / 2.0;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_in_help"] forState:UIControlStateNormal];
        [_button1 setTitle:@"取消求救" forState:UIControlStateNormal];
        _button1.top = _titleLabel.bottom + 20;
        _contentView.height = _button1.bottom + 20;
         _contentView.bottom = self.height - 5 - 10;
    }
    
    //到达
    if (status == TaskStatusArrived) {
        _imageView.image = [UIImage imageNamed:@"img_arrive"];
        _imageView.width = 38;
        _imageView.height = 38;
        _imageView.centerX = _contentView.width / 2.0;
        _imageView.top = 40;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"骑士L72.628已到达" attributes:@{
                                                                                                                           NSFontAttributeName :[UIFont systemFontOfSize:16]
                                                                                                                           }];
        [_titleLabel sizeToFit];
        _titleLabel.top = _imageView.bottom + 15;
        _titleLabel.centerX = _contentView.width / 2.0;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_in_help"] forState:UIControlStateNormal];
        [_button1 setTitle:@"取消求救" forState:UIControlStateNormal];
        _button1.top = _titleLabel.bottom + 20;
        _contentView.height = _button1.bottom + 20;
        _contentView.bottom = self.height - 5 - 10;
    }
    
    //完成
    if (status == TaskStatusComplete) {
        _imageView.image = [UIImage imageNamed:@"img_battery"];
        _imageView.width = 35;
        _imageView.height = 61;
        _imageView.centerX = _contentView.width / 2.0;
        _imageView.top = 40;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"恭喜您完成交换！" attributes:@{
                                                                                                                           NSFontAttributeName :[UIFont systemFontOfSize:16]
                                                                                                                           }];
        [_titleLabel sizeToFit];
        _titleLabel.top = _imageView.bottom + 15;
        _titleLabel.centerX = _contentView.width / 2.0;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"button_in_help"] forState:UIControlStateNormal];
        [_button1 setTitle:@"取消求救" forState:UIControlStateNormal];
        _button1.top = _titleLabel.bottom + 20;
        _contentView.height = _button1.bottom + 20;
        _contentView.bottom = self.height - 5 - 10;
    }
}




@end
