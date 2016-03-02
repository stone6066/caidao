//
//  PublicDefine.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/22.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#ifndef StdTaoYXApp_PublicDefine_h
#define StdTaoYXApp_PublicDefine_h

#import <CoreFoundation/CoreFoundation.h>

#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight      (IOS7==YES ? 0 : 15)

#define fNavBarHeigth (IOS7==YES ? 64 : 44)

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)
#define HomeCellImgHeight (100)
#define HomeCellHeight (203)
#define MainTabbarHeight (50)
#define ConstCityName @"北京"
#define TopSeachHigh (65)
#define AdHight (120)
#define NavTopHight (90)

//#define NSUserDefaultsUserName @"userName"
//#define NSUserDefaultsUserPWD @"userPWD"
#define NSUserJSESSIONID @"JSESSIONID"
#define NSUserTypeData @"MyTypeData"

#define NSUserDefaultsMsg @"userMsg"
#define NSUserDefaultsUid @"userUid"
#define NSUserDefaultsNick @"userNickName"
#define NSUserDefaultsUsers @"userName"
#define NSUserIsLogin @"IsLogin"

#define NetUrl @"http://shop.anquan365.org/nst/common.htm?"
#define MainUrl @"http://shop.anquan365.org/"
#define MainToken @"shop.anquan365.org"

#define MainTabbarColor ([UIColor whiteColor])
#define NSUserDefaultsCityInfo @"CityInfo"
#define NSUserDefaultsCityName @"CityName"
#define NSUserDefaultsTypeInfo @"TypeInfo"
#define NSUserDefaultsTypeName @"TypeName"
#define DefaultsImage @"noPic"

#define HomeAdUrl1 @"http://img-ta-01.b0.upaiyun.com/14527376067968732.jpg"
#define HomeAdUrl2 @"http://img-ta-01.b0.upaiyun.com/14527376044208672.jpg"
#define HomeAdUrl3 @"http://img-ta-01.b0.upaiyun.com/14527376054063309.jpg"


// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define navigationBarColor RGB(33, 192, 174)
#define separaterColor RGB(200, 199, 204)
#define tabTxtColor RGB(107, 107, 107)
#define collectionBgdColor RGB(237, 237, 237)
#define topSearchBgdColor RGB(242, 125, 39)
#define TitleCollectionColor RGB(241, 83, 82)
#define SettingViewColor RGB(239, 239, 244)
#define MyGrayColor RGB(245, 245, 245)
#pragma mark -

#if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON

#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#else	// #if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

#endif	// #if __has_feature(objc_instancetype)

#undef	DEF_SINGLETON_AUTOLOAD
#define DEF_SINGLETON_AUTOLOAD( __class ) \
DEF_SINGLETON( __class ) \
+ (void)load \
{ \
[self sharedInstance]; \
}

#pragma mark -

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS8_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define IOS7_OR_EARLIER		( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER		( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER		( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER		( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER		( !IOS4_OR_LATER )

#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS7_OR_LATER		(NO)
#define IOS6_OR_LATER		(NO)
#define IOS5_OR_LATER		(NO)
#define IOS4_OR_LATER		(NO)
#define IOS3_OR_LATER		(NO)

#define IS_SCREEN_4_INCH	(NO)
#define IS_SCREEN_35_INCH	(NO)

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)


#endif
