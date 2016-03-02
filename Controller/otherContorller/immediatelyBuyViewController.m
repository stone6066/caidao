//
//  immediatelyBuyViewController.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "immediatelyBuyViewController.h"
#import "PublicDefine.h"

@interface immediatelyBuyViewController ()

@end

@implementation immediatelyBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    [self loadNavTopView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setBuyUrl:(NSString *)buyUrl
{
    _buyUrl=buyUrl;
}
-(void) loadWebView{
    self.view.backgroundColor=collectionBgdColor;//[UIColor whiteColor];
    self.navigationController.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *leftbtn=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickleftbtn)];
    [self.navigationItem setLeftBarButtonItem:leftbtn];
    self.navigationItem.title=@"立即购买";
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh-20, fDeviceWidth, fDeviceHeight-TopSeachHigh+20)];
    [webView setDelegate:self];
    
    
    NSLog(@"%@",_buyUrl);
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_buyUrl]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    viewTitle.text=@"立即购买";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    [self.view addSubview:topSearch];
}
@end
