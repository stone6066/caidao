//
//  HomeCollectionViewCell.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/23.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "dealModel.h"

#import "PublicDefine.h"
#import "UIImageView+WebCache.h"
#import "JZMTBtnView.h"

@implementation HomeCollectionViewCell



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        
        _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 180)];
        _backView1.backgroundColor=[UIColor whiteColor];
                //创建8个
         NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:@"查号",@"查快递",@"寄快递", @"景点门票",@"酒店",@"开锁",@"股票",@"飞机票",nil];
        NSMutableArray *imgarr=[[NSMutableArray alloc]initWithObjects:@"qureyPhone",@"qureyGoods",@"sendGoods", @"ticket",@"spot",@"unlock",@"stock",@"airTicket",nil];
        
        for (int i = 0; i < 8; i++) {
            if (i < 4) {
                CGRect frame = CGRectMake(i*fDeviceWidth/4-3, 12, fDeviceWidth/4, 80);
                NSString *title =arr[i];//@"测试";
                NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }else {
                CGRect frame = CGRectMake((i-4)*fDeviceWidth/4-3, 92, fDeviceWidth/4, 80);
                NSString *title =arr[i];//@"测试1";
                NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            
        }
        }
         [self addSubview:_backView1];
           }
    return self;
}
//#pragma mark - UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat scrollViewW = scrollView.frame.size.width;
//    CGFloat x = scrollView.contentOffset.x;
//    int page = (x + scrollViewW/2)/scrollViewW;
//    _pageControl.currentPage = page;
//}

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    [_delegate shortCutClick:sender.view.tag];
}
//-(void)showUIWithModel:(dealModel *)model{
//    self.title.text= model.title;
//    
//    self.detail.text = model.Description;
//    self.currPrice.text = model.current_price;
//    self.oldPrice.text = model.list_price;
//    self.deal_id=model.deal_id;
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.deal_url]];
//   }
//
//-(dealModel*)praseModelWithCell:(HomeCollectionViewCell *)cell{
//    dealModel *dm = [[dealModel alloc]init];
//    dm.title=cell.title.text;
//    dm.Description=cell.detail.text;
//    dm.deal_id=cell.deal_id;
//    return dm;
//}
@end
