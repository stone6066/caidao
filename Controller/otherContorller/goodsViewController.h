//
//  goodsViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/6.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface goodsViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDelegate>
{
   // UIWebView *webView;

    //UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic, retain) UIWebView *webView;
-(void)setGoodsUrl:(NSString *)goodsUrl;


@end
