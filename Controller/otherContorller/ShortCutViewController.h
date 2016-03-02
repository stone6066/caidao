//
//  ShortCutViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/12/1.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//8个快捷方式的webview

#import <UIKit/UIKit.h>

@interface ShortCutViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,copy)NSString *weburl;
@property(nonatomic,copy)NSString *topTitle;

-(void)setWeburl:(NSString *)weburl;
@end
