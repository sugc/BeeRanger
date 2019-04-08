//
//  LocationManager.h
//  BeeRanger
//
//  Created by sugc on 2019/4/7.
//  Copyright © 2019 sugc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class LocationManager;

@protocol LocationManagerDelegate <NSObject>

- (void)locationManager:(LocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations;

@end

@interface LocationManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, weak) id<LocationManagerDelegate> delegate;

@property (nonatomic, copy, readonly) CLLocation *location;

@end
