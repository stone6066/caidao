//
//  goodsViewController.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/6.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "goodsViewController.h"
#import "PublicDefine.h"
//#import "WebViewJavascriptBridge.h"
#import "immediatelyBuyViewController.h"
#import "MBProgressHUD.h"

@interface goodsViewController ()
{
    NSURLConnection *_goodsconnection;
    NSMutableData   *_goodsresponseData;
}
@property(nonatomic,strong)UIButton *myBtn;
//@property WebViewJavascriptBridge* bridge;
@property (nonatomic,strong)NSString *goodsUrl;
@end

@implementation goodsViewController

@synthesize webView = _webView;



-(void)setGoodsUrl:(NSString *)goodsUrl
{
     _goodsUrl=goodsUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavTopView];
    [self loadWebView];
    [self loadBottomBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

//收藏、加入购物车、立即购买
-(void)loadBottomBtn{
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, fDeviceHeight-TopSeachHigh+10, fDeviceWidth, 50)];
    //bottomView.backgroundColor=[UIColor yellowColor];
    UIButton *collectBtn=[[UIButton alloc]init];
    collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(28, 0, 44, 50);
    [collectBtn setBackgroundImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(addToMyCollect) forControlEvents:UIControlEventTouchUpInside];
    collectBtn.clipsToBounds = YES;
    collectBtn.hidden = NO;
    [bottomView addSubview:collectBtn];
    
    
    
    UIButton *buyBtn=[[UIButton alloc]init];
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(100, 0, (fDeviceWidth-100)/2, 50);
    buyBtn.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:80.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    //[buyBtn setBackgroundImage:[UIImage imageNamed:@"ljgm.png"] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyGoodClick) forControlEvents:UIControlEventTouchUpInside];
    buyBtn.clipsToBounds = YES;
    buyBtn.hidden = NO;
    [bottomView addSubview:buyBtn];
    
    UIButton *addCarBtn=[[UIButton alloc]init];
    addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addCarBtn.frame = CGRectMake(100+(fDeviceWidth-100)/2, 0, (fDeviceWidth-100)/2, 50);
    [addCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    //[addCarBtn setBackgroundImage:[UIImage imageNamed:@"addCar.png"] forState:UIControlStateNormal];
    addCarBtn.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:148.0f/255.0f blue:2.0f/255.0f alpha:1.0f];
    [addCarBtn addTarget:self action:@selector(addToMyCar) forControlEvents:UIControlEventTouchUpInside];
    addCarBtn.clipsToBounds = YES;
    addCarBtn.hidden = NO;
    [bottomView addSubview:addCarBtn];
    
    [self.view addSubview:bottomView];
    
}
-(void)addToMyCollect{
   
    NSLog(@"收藏");
}
-(void)buyGoodClick{
    immediatelyBuyViewController *buyView=[[immediatelyBuyViewController alloc]init];
    buyView.hidesBottomBarWhenPushed=YES;
    buyView.navigationItem.hidesBackButton=YES;
    NSString *myBuyUrl= [self.webView stringByEvaluatingJavaScriptFromString:@"getGoodsHrefToBuy();"];
     NSLog(@"购物车地址：%@",myBuyUrl);
    [buyView setBuyUrl:myBuyUrl];
    [self.navigationController pushViewController:buyView animated:YES];
}
-(void)addToMyCar{
    NSString *addCarUrl= [self.webView stringByEvaluatingJavaScriptFromString:@"getGoodsHrefToCar();"];
    NSLog(@"购物车地址：%@",addCarUrl);
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:addCarUrl]];
    _goodsconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}
- (void)createBackBtn
{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //[back setTitle:@"Back" forState:UIControlStateNormal];
    [back setFrame:CGRectMake(5, 2, 60, 24)];
    [back setBackgroundImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = barButton;
}

-(void) loadWebView{

    [self createBackBtn];
    self.navigationItem.title=@"商品详情";
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-113)];
//    webView.delegate = self;
//    self.webView = webView;
//    //[webView release];
//    [self.view addSubview:_webView];
//    
//    NSString *strurl=[[NSString alloc]initWithFormat:@"%@%@%@",@"http://www.tao-yx.com/mobile/item/",_goodId,@".html"];
//    
//    NSLog(@"%@",strurl);
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:strurl]];
//    [self.view addSubview: self.webView];
//    
//    [self.webView loadRequest:request];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh*2+13)];
    [self.webView setDelegate:self];
    
    NSString *strurl=_goodsUrl;//[[NSString alloc]initWithFormat:@"%@%@%@",@"http://www.tao-yx.com/mobile/item/",_goodId,@".html"];
    
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:strurl]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"left");

}
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight)];
//    [view setTag:108];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.5];
//    [self.view addSubview:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    
    NSLog(@"webViewDidStartLoad");
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    //[activityIndicator stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:108];
//    [view removeFromSuperview];
    //加载js文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mytest" ofType:@"js"];
    NSString *jsString = [[NSString alloc] initWithContentsOfFile:filePath];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"webViewDidFinishLoad");
    
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[activityIndicator stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:108];
//    [view removeFromSuperview];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"didFailLoadWithError:%@", error);
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest");
    return YES;//return NO 的时候，webview就不会加载页面了
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(void)clickbtn{
//        NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
//    NSLog(@"testUrl:%@",currentURL);
//    
//    //获取商品数量
//    NSString *goodsCount = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('count_num')[0].value"];
//    
//    NSString *goodsColor = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('choose_item _sku attr selected')[1].data-value"];
//    
//     NSLog(@"testTitle:%@",goodsColor);
   
    // NSString *js_result2 = [webView stringByEvaluatingJavaScriptFromString:@"document.forms[0].submit(); "];
    
     NSString *txt= [self.webView stringByEvaluatingJavaScriptFromString:@"getSelectSize();"];
     NSLog(@"testTitle:%@",txt);
   // sendMessage(self);
}


- (void)disconnect
{
    _goodsresponseData = nil;
    [_goodsconnection cancel];
    _goodsconnection = nil;
}


#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _goodsresponseData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_goodsresponseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    _goodsresponseData = nil;
    [_goodsconnection cancel];
    _goodsconnection = nil;
    NSLog(@"加入购物车成功");
    [self showMessage:@"加入购物车成功"];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    _goodsresponseData = nil;
    [_goodsconnection cancel];
    _goodsconnection = nil;
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
}


- (void)showAlert
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"已添加到购物车" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    [promptAlert show];
}

-(void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((fDeviceWidth - LabelSize.width - 20)/2, fDeviceHeight - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:5.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //[back setTitle:@"Back" forState:UIControlStateNormal];
    [back setFrame:CGRectMake(8, 24, 60, 24)];
    [back setBackgroundImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:back];
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-50, 16, 100, 40)];
    viewTitle.text=@"商品详情";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    [self.view addSubview:topSearch];
}
@end
