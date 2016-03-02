//
//  StdRootController.m
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "StdRootController.h"
#import "PublicDefine.h"



@implementation StdRootController
-(void)SetUpStdRootView:(UITabBarController *)rootTab
{
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    homeViewController.view.backgroundColor = [UIColor whiteColor];
    
    SortViewController *sortViewController = [[SortViewController alloc]init];
    sortViewController.view.backgroundColor = [UIColor whiteColor];
    
    NewsViewController *newsViewController = [[NewsViewController alloc]init];
    newsViewController.view.backgroundColor = [UIColor whiteColor];
    
    ShopCarViewController *shopCarViewController = [[ShopCarViewController alloc]init];
    shopCarViewController.view.backgroundColor = [UIColor whiteColor];
    
    AccountViewController *accountViewController = [[AccountViewController alloc]init];
    accountViewController.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    UINavigationController *sort = [[UINavigationController alloc] initWithRootViewController:sortViewController];
    
    UINavigationController *news = [[UINavigationController alloc] initWithRootViewController:newsViewController];
    
    UINavigationController *shop = [[UINavigationController alloc] initWithRootViewController:shopCarViewController];
    
    UINavigationController *account = [[UINavigationController alloc] initWithRootViewController:accountViewController];
    
    //rootTab.viewControllers = [NSArray arrayWithObjects:homeViewController, sortViewController,orderViewController,shopCarViewController,accountViewController, nil];
    rootTab.viewControllers = [NSArray arrayWithObjects:home, sort,news,shop,account, nil];
    
    rootTab.tabBar.frame=CGRectMake(0, fDeviceHeight-MainTabbarHeight, fDeviceWidth, MainTabbarHeight);
    
    
    for (UINavigationController *stack in rootTab.viewControllers) {
        [self setupNavigationBar:stack];
    }
//    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 55)];
//    UIImageView * backBgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 20)];
//    backBgV.userInteractionEnabled = YES;
//    backBgV.image = [UIImage imageNamed:@"redtop.png"];
//    backBgV.userInteractionEnabled = YES;
//    [topSearch addSubview:backBgV];
    
//    UIImageView * seachBgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, fDeviceWidth, 35)];
//    seachBgV.userInteractionEnabled = YES;
//    seachBgV.image =[UIImage imageNamed:@"查找.png"]; //bundleImageImageName(@"查找.png");
//    seachBgV.userInteractionEnabled = YES;
//    [topSearch addSubview:seachBgV];
//    UIBarButtonItem *topBarBtn=[[UIBarButtonItem alloc]initWithCustomView:topSearch];
//    home.navigationItem.rightBarButtonItem=topBarBtn;
   
    
    rootTab.tabBar.barStyle=UIBarStyleDefault;
    rootTab.tabBar.translucent=false;
    rootTab.tabBar.tintColor=tabTxtColor;
   
//    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbackground.png"];
//    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbackground.png"]];

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //NSLog(@"123123");
//    int index = viewController.selectedIndex;
//    NSString *titleName = nil;
//    switch (index) {
//        case 0:
//            titleName = @"FirstView";
//            break;
//        case 1:
//            titleName = @"SecondView";
//            break;
//        case 2:
//            titleName = @"ThirdView";
//            break;
//            
//        default:
//            break;
//    }
}

- (void)setupNavigationBar:(UINavigationController *)stack{
    UIImage *barImage = [UIImage imageNamed:@"redtop.png"];
    if(IOS7_OR_LATER)
        [stack.navigationBar setBackgroundImage:barImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    else
        [stack.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    
}
@end
