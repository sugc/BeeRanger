//
//  LocationManager.m
//  BeeRanger
//
//  Created by sugc on 2019/4/7.
//  Copyright © 2019 sugc. All rights reserved.
//

#import "LocationManager.h"


@interface LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation LocationManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static LocationManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[LocationManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self starLocationMonit];
    }
    return self;
}


- (void)starLocationMonit {
    
    _manager = [[CLLocationManager alloc] init];
    _manager.delegate = self;
    [_manager requestWhenInUseAuthorization];
    [_manager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if ([_delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
        [_delegate locationManager:self didUpdateLocations:locations];
    }
}

- (CLLocation *)location {
    return _manager.location;
}

- (void)resetMapViewToCenter {
    if ([_delegate respondsToSelector:@selector(resetMapViewToCenter)]) {
        [_delegate resetMapViewToCenter];
    }
}

@end
