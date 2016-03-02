//
//  stdPubFunc.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "stdPubFunc.h"
#import "PublicDefine.h"
#import "DPAPI.h"

@implementation stdPubFunc

+(void)stdShowMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    float lblH=80;
    float lblW=100;
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    //label.frame = CGRectMake(10, 5, lblW, lblH);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((fDeviceWidth -LabelSize.width - 20)/2, fDeviceHeight/2-50, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:5.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}




+(NSString*)readUserMsg{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * Msg = [user objectForKey:NSUserDefaultsMsg];
    return Msg;
}
+(NSString*)readUserUid{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * UserUid = [user objectForKey:NSUserDefaultsUid];
    return UserUid;
}
+(NSString*)readUserNick{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * UserNick = [user objectForKey:NSUserDefaultsNick];
    return UserNick;
}
+(NSString*)readUserName{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * UserName = [user objectForKey:NSUserDefaultsUsers];
    return UserName;
}
+(void)setIsLogin:(NSString*)islogin{
    NSUserDefaults *myuser = [NSUserDefaults standardUserDefaults];
    [myuser setObject:islogin forKey:NSUserIsLogin];
    [myuser synchronize];
}
+(NSString*)getIsLogin{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * islogin = [user objectForKey:NSUserIsLogin];
    return islogin;
}
@end
