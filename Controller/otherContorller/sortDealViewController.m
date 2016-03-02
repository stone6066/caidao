//
//  sortDealViewController.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "sortDealViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "MJRefresh.h"
#import "dealModel.h"
#import "ShopViewCell.h"
#import "goodsViewController.h"

@interface sortDealViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_dataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSMutableArray *_fakeColor;
    MJRefreshFooterView *_footer;//上拉刷新
    MJRefreshHeaderView *_header;//下拉刷新
    NSString *_sortAllwaysFlash;
}
@property(nonatomic,copy)NSString *sortListId;
@property(nonatomic,copy)NSString *topTitle;
@end


@implementation sortDealViewController
static NSString * const mySortIdentifier = @"MainCell";

-(void)setSortListId:(NSString *)sortListId
{
    _sortListId=sortListId;
}
-(void)setTopTitle:(NSString *)topTitle
{
    _topTitle=topTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
    [self loadCollectionView];
    [self loadBackToTopBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //[self loadWebView];
   
}



-(void)clickleftbtn{
   
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"left");
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

-(void)loadCollectionView{
    //[self createBackBtn];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    //-----------------------------------------
    
    self.collectionView.backgroundColor =collectionBgdColor;// [UIColor whiteColor];
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShopViewCell" bundle:nil] forCellWithReuseIdentifier:mySortIdentifier];
    
    _pageindex=1;
    _sortAllwaysFlash=@"0";
    [self createRequest];
    _dataSource = [NSMutableArray array];//还要再搞一次，否则_dataSource装不进去数据
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.collectionView;
    header.delegate = self;
    _header=header;
    // 集成刷新控件
    // 上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionView;
    footer.delegate = self;
    _footer = footer;
    
    
}

# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    _selectedCityName=@"哈尔滨";
    _selectedCategory=@"";
    NSInteger mylimit=20;
    [params setValue:_selectedCityName forKey:@"city"];
    [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"page"];
    [params setValue:[NSNumber numberWithInteger:mylimit] forKey:@"limit"];
    //[params setValue:_selectedCategory forKey:@"category"];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //NSLog(@"%@",result);
    NSDictionary *dict = result;
    dealModel *md = [[dealModel alloc]init];
    NSArray *datatmp=[md asignModelWithDict:dict];
    
    [_dataSource addObjectsFromArray:datatmp];
    [self.collectionView reloadData];
}
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mySortIdentifier forIndexPath:indexPath];
    //[cell sizeToFit];
    dealModel *md=_dataSource[indexPath.item];
    [cell showUIWithModel:md];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((fDeviceWidth/2)-3, HomeCellHeight);
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2, 2, 2);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//定义每行UICollectionCellView 的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ShopViewCell *svc =(ShopViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
//    dealModel *dm= [svc praseModelWithCell:svc];
//    NSLog(@"%ld---%@---dmdmdm:",indexPath.item,dm.deal_id);
    ShopViewCell *svc =(ShopViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    dealModel *dm= [svc praseModelWithCell:svc];
    NSLog(@"%ld---%@---dmdmdm:",indexPath.item,dm.dealurl);
    
    goodsViewController *goodsView=[[goodsViewController alloc]init];
    goodsView.hidesBottomBarWhenPushed=YES;
    goodsView.navigationItem.hidesBackButton=YES;
    NSString *strurl=[[NSString alloc]initWithFormat:@"%@%@%@",@"http://www.tao-yx.com/mobile/item/",@"20457",@".html"];
    [goodsView setGoodsUrl:strurl];
    
    [self.navigationController pushViewController:goodsView animated:YES];
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.collectionView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSString *myClass=refreshView.description;
    NSRange myRang=[myClass rangeOfString:@"MJRefreshHeaderView"];
    
    if (myRang.length>0) {//下拉强制刷新
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        _selectedCityName=ConstCityName;
        _selectedCategory=@"";
        _pageindex=1;
        [params setValue:_selectedCityName forKey:@"city"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"page"];
        _sortAllwaysFlash=@"1";//强制刷新
        [api setAllwaysFlash:_sortAllwaysFlash];
        [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
        
        // 2.2秒后刷新表格UI
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    }
    else
    {
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        _selectedCityName=ConstCityName;
        _selectedCategory=@"";
        _pageindex+=1;
        [params setValue:_selectedCityName forKey:@"city"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"page"];
        [api setAllwaysFlash:_sortAllwaysFlash];
        [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
        
        // 2.2秒后刷新表格UI
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    }
    
}

#pragma mark 刷新完毕
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----刷新完毕", refreshView.class);
}

-(void)dealloc
{
    [_header removeFromSuperview];
    [_footer removeFromSuperview];
}

-(void)loadBackToTopBtn{
    // 添加回到顶部按钮
    _sortTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sortTopBtn.frame = CGRectMake(fDeviceWidth-50, fDeviceHeight-60, 40, 40);
    [_sortTopBtn setBackgroundImage:[UIImage imageNamed:@"back2top.png"] forState:UIControlStateNormal];
    [_sortTopBtn addTarget:self action:@selector(backToTopButton) forControlEvents:UIControlEventTouchUpInside];
    _sortTopBtn.clipsToBounds = YES;
    _sortTopBtn.hidden = YES;
    [self.view addSubview:_sortTopBtn];
}
- (void)backToTopButton{
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}
// MARK:  计算偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //MARK:列表滑动偏移量计算
    CGPoint point = [self.collectionView contentOffset];
    
    if (point.y >= self.collectionView.frame.size.height) {
        self.sortTopBtn.hidden = NO;
        [self.view bringSubviewToFront:self.sortTopBtn];
    } else {
        self.sortTopBtn.hidden = YES;
    }
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
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-80, 16, 150, 40)];
    viewTitle.text=_topTitle;
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    [self.view addSubview:topSearch];
}

@end
