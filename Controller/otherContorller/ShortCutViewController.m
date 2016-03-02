//
//  ShortCutViewController.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/12/1.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "ShortCutViewController.h"
#import "PublicDefine.h"

@interface ShortCutViewController ()
{
    UIButton *back;
   
}
@end

@implementation ShortCutViewController

-(void)setWeburl:(NSString *)weburl
{
    _weburl=weburl;
}
-(void)setTopTitle:(NSString *)topTitle
{
    _topTitle=topTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadWebView{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-25, 18, 80, 40)];
    topLbl.text=_topTitle;
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    
    
    back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //[back setFrame:CGRectMake(8, 22, 80, 24)];
    [back setFrame:CGRectMake(8, 27, 60, 24)];
    [back setBackgroundImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    back.hidden=NO;
    
    [self.view addSubview:TopView];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    [webView setDelegate:self];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_weburl]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *location=webView.request.URL.absoluteString;
    if ([location isEqualToString:@"http://www.tao-yx.com/mobile/"]) {
        back.hidden=YES;
    }
    else
        back.hidden=NO;
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
    NSLog(@"webViewDidFinishLoad123");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest");
    return YES;//return NO 的时候，webview就不会加载页面了
}
-(void)clickleftbtn
{
    if ([webView canGoBack]) {
        [webView goBack];
        NSLog(@"canGoBack");
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
//        NSLog(@"nocanGoBack");
//        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.tao-yx.com/mobile/"]];
//        [webView loadRequest:request];
    }
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
   
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];

    NSLog(@"didFailLoadWithError:%@", error);
}


@end
