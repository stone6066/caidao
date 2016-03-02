//
//  immediatelyBuyViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//立即购买

#import <UIKit/UIKit.h>

@interface immediatelyBuyViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,copy)NSString *buyUrl;
-(void)setBuyUrl:(NSString *)buyUrl;
@end
