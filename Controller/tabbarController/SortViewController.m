//
//  SortViewController.m
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "SortViewController.h"
#import "MultilevelMenu.h"
#import "PublicDefine.h"
#import "SearchViewController.h"
#import "sortDealViewController.h"
#import "SYQRCodeViewController.h"
#import "goodsViewController.h"
#import "DPAPI.h"
#import "sortModel.h"

@interface SortViewController ()<UITextFieldDelegate,DPRequestDelegate>
{
UITextField * _seachTextF;
}
@end

@implementation SortViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"assortment_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = [[UIImage imageNamed:@"assortment"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *tittxt=@"分类";
        self.tabBarItem.title=tittxt;
        self.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
    [self loadsortSeachView];
    [self typeCreateRequest];
    
}


-(void)loadSortView:(NSArray*)dataArr{
    //NSMutableArray * menuAllLis=[NSMutableArray arrayWithCapacity:0];
    /**
     *  构建需要数据 2层或者3层数据 (ps 2层也当作3层来处理)
     */
//    NSInteger countMax=6;
//    for (int i=0; i<countMax; i++) {
//        
//        rightMeun * meun=[[rightMeun alloc] init];
//        meun.meunName=[NSString stringWithFormat:@"左侧列表%d",i];
//        NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
//        
//        
//        rightMeun * meun1=[[rightMeun alloc] init];
//        meun1.meunName=[NSString stringWithFormat:@"右侧组%d标题",i];
//        
//        [sub addObject:meun1];
//        
//        
//        NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
//        
//        
//        for ( int z=0; z <i+1; z++) {
//            
//            rightMeun * meun2=[[rightMeun alloc] init];
//            meun2.meunName=[NSString stringWithFormat:@"右侧%d标签%d",i,z];
//            [zList addObject:meun2];
//            
//        }
//        
//        meun1.nextArray=zList;
//        
//        
//        
//        meun.nextArray=sub;
//        [menuAllLis addObject:meun];
//    }
    
    /**
     *  适配 ios 7 和ios 8 的 坐标系问题
     */
    //self.automaticallyAdjustsScrollViewInsets=NO;
    
    /**
     默认是 选中第一行
     
     :returns: <#return value description#>
     */
    MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh-MainTabbarHeight) WithData:dataArr withSelectIndex:^(NSInteger left, NSInteger right,rightMeun* info) {
        sortDealViewController *sortDealView=[[sortDealViewController alloc]init];
        //sortDealView.navigationItem.title=info.meunName;
        sortDealView.hidesBottomBarWhenPushed=YES;
        sortDealView.navigationItem.hidesBackButton=YES;
        [sortDealView setSortListId:@"4148"];
        [sortDealView setTopTitle:info.meunName];
        [self.navigationController pushViewController:sortDealView animated:YES];
        //NSLog(@"点击的 菜单%@",info.meunName);
    }];
    
    [self.view addSubview:view];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    // Do any additional setup after loading the view.
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_seachTextF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

UIImage * sbundleImageImageName(NSString  *imageName)
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",imageName] ofType:nil inDirectory:@""];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:path];
    return image;
}
- (void)loadsortSeachView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
//    UIImageView * seachLogo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 30, 30)];
//    seachLogo.userInteractionEnabled = YES;
//    seachLogo.image =[UIImage imageNamed:@"topLogo"];
//    seachLogo.userInteractionEnabled = YES;
//    [topSearch addSubview:seachLogo];
    
    UIImageView * seachBgV = [[UIImageView alloc] initWithFrame:CGRectMake(45, 25, fDeviceWidth-95, 30)];
    seachBgV.userInteractionEnabled = YES;
    seachBgV.image =[UIImage imageNamed:@"seachBgd"];
    seachBgV.userInteractionEnabled = YES;
    [topSearch addSubview:seachBgV];
    
    
    UIImageView * scanLogo = [[UIImageView alloc] initWithFrame:CGRectMake(fDeviceWidth-40, 25, 22, 22)];
    scanLogo.userInteractionEnabled = YES;
    scanLogo.image =[UIImage imageNamed:@"scan"];
    scanLogo.userInteractionEnabled = YES;
    [topSearch addSubview:scanLogo];
    
    
    UILabel *scanTxt=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-41, 45, 40, 20)];
    scanTxt.text=@"扫一扫";
    scanTxt.font=[UIFont systemFontOfSize:8];
    scanTxt.textColor=[UIColor whiteColor];
    [topSearch addSubview:scanTxt];
    
    UIButton * scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(topSearch.frame.size.width-48, 0, 50, 50)];
    
    //scanBtn.backgroundColor=[UIColor yellowColor];
    [scanBtn addTarget:self action:@selector(doScan:) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:scanBtn];
    [self.view addSubview:topSearch];
    
    
    _seachTextF = [[UITextField alloc] initWithFrame:CGRectMake(35, -1, fDeviceWidth-100-35, 35)];
    _seachTextF.backgroundColor = [UIColor clearColor];
    [_seachTextF setTintColor:[UIColor blueColor]];
    _seachTextF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    UIColor *mycolor=[UIColor whiteColor];
    _seachTextF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"搜索你喜欢的商品" attributes:@{NSForegroundColorAttributeName: mycolor}];
    
    _seachTextF.textColor=[UIColor whiteColor];
    [seachBgV addSubview:_seachTextF];
    _seachTextF.delegate=self;
    UIButton * seachBtn = [[UIButton alloc] initWithFrame:CGRectMake(45, 24, 40, 35)];
    [seachBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [topSearch addSubview:seachBtn];
    [seachBtn setImage:[UIImage imageNamed:@"queryBtn@2x"] forState:UIControlStateNormal];
    [seachBtn setImage:[UIImage imageNamed:@"queryBtn@2x"] forState:UIControlStateHighlighted];
    [seachBtn addTarget:self action:@selector(doSeach:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)sortHiddenKeyBoard
{
    if ([_seachTextF isFirstResponder]) {
        [_seachTextF resignFirstResponder];
    }
}

- (void)doScan:(UIButton *)button
{
    SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
    qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        goodsViewController *goodsView=[[goodsViewController alloc]init];
        goodsView.hidesBottomBarWhenPushed=YES;
        goodsView.navigationItem.hidesBackButton=YES;
        
        [goodsView setGoodsUrl:qrString];
        [self.navigationController pushViewController:goodsView animated:YES];
        
    };
    qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:qrcodevc animated:YES completion:nil];
}

-(void)sortShowTabbar{
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:NO];
        }
    }
}
- (void)doSeach:(UIButton *)button
{
    if (_seachTextF.text.length==0) {
        //MCshowAlertWithTitle(@"", @"搜索内容不能为空");
        NSLog(@"%@",@"搜索内容不能为空");
        [self sortHiddenKeyBoard];
        [self sortShowTabbar];
        return;
    }
    [self sortHiddenKeyBoard];
    //[tabBarViewController ];
    NSLog(@"%@----%@",@"搜索doSeach",_seachTextF.text);
    //[self hideTabbar];
    SearchViewController *seachView = [[SearchViewController alloc] init];
    
    seachView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seachView animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    [self doSeach:nil];
    return YES;
}


//下载分类数据
- (void)typeCreateRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
   
    [params setValue:@"typeandbrand" forKey:@"ut"];
    
    [api setAllwaysFlash:@"1"];
    
    [api typeRequestWithURL: NetUrl params:params delegate:self];
}

-(void)typerequest:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSDictionary *dict = result;
    sortModel *SM=[[sortModel alloc]init];
    NSArray *datatmp=[SM asignModelWithDict:dict];
    [self loadSortView:datatmp];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
