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
#import <MapKit/MapKit.h>
#import "NewWorkManager/NewWorkManager.h"
#import "LocationManager.h"
#import "StatusView.h"

@interface ViewController ()<LocationManagerDelegate,NetWorkDelegate>
    
@property (nonatomic, strong) UIView *mapContentView;
    
@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) StatusView *statusView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layout];
    [LocationManager shareInstance].delegate = self;
    [NewWorkManager shareInstance].delegate = self;
    [NewWorkManager shareInstance];
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


- (void)layout {
    
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
    [self addMapView];
    
    _statusView = [[StatusView alloc] initWithFrame:_mapContentView.frame];
    [self.view addSubview:_statusView];
    
    [avatarBtn addTarget:self action:@selector(goNextForce) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addMapView {    
    _mapView = [[MKMapView alloc] initWithFrame:_mapContentView.bounds];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    [_mapContentView addSubview:_mapView];
    
}


- (void)setRegionWithCenter:(CLLocationCoordinate2D)center {
    //也可以使用如下方式设置经度、纬度
    //center.latitude = latitude;
    //center.longitude = longitude;
    //设置地图显示的范围
    MKCoordinateSpan span;
    //地图显示范围越小，细节越清楚；
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    //创建MKCoordinateRegion对象，该对象代表地图的显示中心和显示范围
    MKCoordinateRegion region = {center,span};
    //设置当前地图的显示中心和显示范围
    [self.mapView setRegion:region animated:YES];
}

//
- (void)showGuysNeedHelp {
    //显示需要帮助的人
    
    
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (manager.location) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self setRegionWithCenter:manager.location.coordinate];
        });
    }
}

- (void)resetMapViewToCenter {
    [self setRegionWithCenter:[LocationManager shareInstance].location.coordinate];
}



- (void)updateStatus:(TaskStatus)status isIntask:(BOOL)isInTask msg:(NSDictionary *)msg {
    status = [msg[@"status"] integerValue];
    [self.statusView changeToStatus:status msg:msg animate:YES];
}

//各种视图展示， UI相关


//强制进入下一步
- (void)goNextForce {
    TaskStatus status = self.statusView.status + 1;
    if (status >= TaskStatusNone) {
        status = TaskStatusRequest;
    }
    [self.statusView changeToStatus:status msg:nil animate:YES];
}

@end
