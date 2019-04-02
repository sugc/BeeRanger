//
//  ViewController.m
//  BeeRanger
//
//  Created by sugc on 2019/3/28.
//  Copyright © 2019 sugc. All rights reserved.
//

#import "ViewController.h"
#import "UtilsDef.h"
#import "UIView+FrameAccessor.h"

@interface ViewController ()
    
@property (nonatomic, strong) UIView *mapContentView;
    
@property (nonatomic, strong) UIView *topBarView;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _topBarView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                           24,
                                                           KScreenWidth,
                                                           44)];
    _topBarView.backgroundColor = [UIColor whiteColor];
    CGFloat btnW = 44;
    UIButton *avatarBtn = [[UIButton alloc] initWithFrame:CGRectMake(15,
                                                                     (_topBarView.height - btnW) / 2.0,
                                                                     btnW,
                                                                     btnW)];
    [avatarBtn setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 15 - 44, avatarBtn.top, 44, 44)];
    [settingBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"BEE RANGER";
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.centerX = _topBarView.width / 2.0;
    label.centerY = _topBarView.height / 2.0;
    
    [_topBarView addSubview:avatarBtn];
    [_topBarView addSubview:settingBtn];
    [_topBarView addSubview:label];
    [self.view addSubview:_topBarView];
    
//    self.view.backgroundColor = [UIColor grayColor];
    
    //地图View
    
    _mapContentView = [[UIView alloc] initWithFrame:CGRectMake(0, _topBarView.bottom, KScreenWidth, KScreenHeight - _topBarView.bottom)];
    _mapContentView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_mapContentView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

@end
