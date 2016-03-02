//
//  stdPubFunc.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface stdPubFunc : NSObject
+(void)stdShowMessage:(NSString *)message;

+(NSString*)readUserMsg;

+(NSString*)readUserUid;

+(NSString*)readUserNick;

+(NSString*)readUserName;

+(void)setIsLogin:(NSString*)islogin;

+(NSString*)getIsLogin;

@end
