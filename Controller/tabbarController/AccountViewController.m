//
//  AccountViewController.m
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "AccountViewController.h"
#import "UIImageView+WebCache.h"
#import "PublicDefine.h"
#import "ShortCutViewController.h"
@interface AccountViewController ()
{
    NSMutableArray *_tableDataSource;
}
@end

@implementation AccountViewController

- (void)viewDidLoad {
   [super viewDidLoad];
    //
    // Do any additional setup after loading the view.
  
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"我的");
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self loadNavTopView];
    [self loadUserImage];
    [self loadTableView];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"myInfo_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"myInfo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSString *tittxt=@"我的";
        self.tabBarItem.title=tittxt;
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
        
       
    }
    return self;
}
- (void)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if(tabBarController.selectedIndex == 4)    //"我的账号"
    {
        NSLog(@"我的");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)clickleftbtn{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"left");
    
}



- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-30, 16, 50, 40)];
    viewTitle.text=@"我的";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    [self.view addSubview:topSearch];
}
-(void)loadUserImage{
    UIView *imgView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 150)];
    
    UIImageView *backImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 120)];
    
    [backImg sd_setImageWithStr:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/images/images_25.jpg" ]];
    [imgView addSubview:backImg];
    
    
    
    UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 60, 70, 70)];
    [iconImg sd_setImageWithStr:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/images/avatar.jpg"]];
    
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = CGRectGetHeight(iconImg.bounds)/2;
    //    注意这里的ImageView 的宽和高都要相等
    //    layer.cornerRadiu 设置的是圆角的半径
    //    属性border 添加一个镶边
    iconImg.layer.borderWidth = 0.5f;
    iconImg.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [imgView addSubview:iconImg];
    
    UILabel *userLbl=[[UILabel alloc]initWithFrame:CGRectMake(90, 100, 100, 20)];
    userLbl.font=[UIFont systemFontOfSize:15];
    //userLbl.text=[stdPubFunc readUserName];
    [userLbl setTextColor:[UIColor whiteColor]];
    [imgView addSubview:userLbl];
    
    imgView.backgroundColor=MyGrayColor;
    [self.view addSubview:imgView];
    
}
-(void)loadTableView{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+150, fDeviceWidth, fDeviceHeight-TopSeachHigh-MainTabbarHeight)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    _tableDataSource=[[NSMutableArray alloc]initWithObjects:@"我的订单",@"待付款订单",@"已发货物流查询",@"收货地址管理",@"个人资料", nil];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setFrame:CGRectMake(fDeviceWidth/2-90, fDeviceHeight-140, 180, 50)];
    [publishBtn addTarget:self action:@selector(clickOutbtn) forControlEvents:UIControlEventTouchUpInside];
    [publishBtn setTitle:@"退出登录状态" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishBtn.backgroundColor=topSearchBgdColor;
    [self.view addSubview:publishBtn];
    //self.tableView.backgroundColor=collectionBgdColor;
}
-(void)clickOutbtn{
    //[self createLoginOutRequest];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"MyInfotableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    UIImageView* cellImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_filter_arrow@2x"]];
    cell.accessoryView=cellImg;
    cell.textLabel.text = _tableDataSource[indexPath.row];
    
    
    return cell;
    
}

//每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/customer/myorder.html"] viewTitle:@"我的订单"];
            break;
        case 1:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/customer/myorder-0-1.html"] viewTitle:@"待付款订单"];
            break;
        case 2:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/customer/myorder-3-1.html"] viewTitle:@"已发货物流查询"];
            break;
        case 3:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/customer/address.html"] viewTitle:@"收货地址"];
            break;
        case 4:
            
            [self popMobileInfoView:[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/customer/personinfo.html"] viewTitle:@"个人资料"];
            break;
        case 5://我的发布
            //[self popMyPublicView];
            break;
        default:
            break;
    }
    
}

-(void)popMobileInfoView:(NSString*)urlStr viewTitle:(NSString*)sTitle{
    ShortCutViewController *shortCutView=[[ShortCutViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
    
    [shortCutView setWeburl:urlStr];
    [shortCutView setTopTitle:sTitle];
    shortCutView.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:shortCutView animated:YES];
}

@end
