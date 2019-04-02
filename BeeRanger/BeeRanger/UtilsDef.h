//
//  UtilsDef.h
//  BeautyPlus
//
//  Created by Arthur on 16/2/15.
//  Copyright © 2016年 美图网. All rights reserved.
//

#ifndef UtilsDef_h
#define UtilsDef_h

// Constant
 
//#define TEXT(key) (NSLocalizedString(key, nil))

#define SOFTWARE_VERSION	[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define iTunes_APP_ID         @"622434129"
#define BP_PUSH_APP_ID @"6184556697063849985"

#define ScreenSize            [[UIScreen mainScreen] bounds].size
#define ScreenWidth           [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight          [[UIScreen mainScreen] bounds].size.height

#define MIN_IMAGE_WIDTH         [[UIScreen mainScreen] bounds].size.width*3

//美容功能添加尺寸
#define BEAUTY_SHOW_SIZE  640.0f
#define BEAUTY_THUMB_SIZE 80.0f

//Utils


/*
 @note: debug模式日志打印宏
 */
#ifdef DEBUG
#define _MTDebugShowLogs
#endif

#ifdef _MTDebugShowLogs
#define MTDebugShowLogs			1
#define MTString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define MTLOG( ... ) printf(">>> %s-%d: %s\n", [MTString UTF8String], __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define MTDebugShowLogs			0
#define MTLOG( s, ... )

#endif


#define UIViewAutoresizingWidthAndHeight       UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight
#define UIViewAutoresizingAll               UIViewAutoresizingFlexibleLeftMargin| \
UIViewAutoresizingFlexibleWidth|\
UIViewAutoresizingFlexibleRightMargin|\
UIViewAutoresizingFlexibleTopMargin|\
UIViewAutoresizingFlexibleHeight|\
UIViewAutoresizingFlexibleBottomMargin

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define MTWeakObj(o) autoreleasepool{} __weak typeof(o) weak##o = o;
#define MTStrongObj(o) autoreleasepool{} __strong typeof(o) o = weak##o;

//屏幕尺寸
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define BeautyPlusAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define RGB(r,g,b)        [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f]
#define RGBA(r,g,b,a)     [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]
#define RGBAHEX(hex,a)    RGBA((float)((hex & 0xFF0000) >> 16),(float)((hex & 0xFF00) >> 8),(float)(hex & 0xFF),a)

#define IMAGENAMED(file)            [UIImage imageNamed:file]

#define MT_SWAP( x, y )			\
({ __typeof__(x) temp  = (x);		\
x = y; y = temp;		\
})

//Version Util
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define kVideoFiltersAlphaSavePath        [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/VideoFiltersAlpha.plist"]

#define kMTLocalSeverPushPath       [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/mtLocalSeverPushInfo.plist"]
//新接口
#define kMTLocalSeverPushNewPath       [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/mtLocalSeverPushNewInfo.plist"]

#define kMTServerPushSharePath      [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/mtShareSwitchInfo.plist"]
#define kOriginVideoSavePath        [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/OriginMovie.mp4"]

//视频模块
#define kVideoClipSavePath          [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define kClipFilePlist              [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/clips.plist"]
#define kUploadPath                 [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/upload"]

//BEC campaign文件
#define kBecCampaignUploadPath                 [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/becCampaign"]


#define kDocumentDirectory          NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define kDocumentDirectoryURL       [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil]


//Platform Uitls
#define IS_IPHONE_5_8 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )812 ) < DBL_EPSILON )
#define IS_IPHONE_5_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_4_7 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_4_0 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_3_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

#define iPhoneXSafeDistanceTop ((IS_IPHONE_5_8)?44:0)
#define iPhoneXSafeDistanceBottom ((IS_IPHONE_5_8)?34:0)
#define iPhoneXSafeDistance ((IS_IPHONE_5_8)?78:0)

#define KBEC_Legal_Least_Age   16

#define ONE_MINUTE          (60)     // 1分钟
#define ONE_HOUR          (60*60)     // 1小时
#define ONE_DAY           (60*60*24)    // 一天
#define ONE_MOUNTH        (60*60*24*30) //一月
#define ONE_YEAR          (60*60*24*30*12)//一年

// Social Share Key
#define WXApi_APPKEY  @"wx470510056f2009b4"

#endif /* UtilsDef_h */
