//
//  HomeViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/23.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AdvertisingColumn.h"//头部滚动的，不需要可以去掉
#import "AOScrollerView.h"
@interface HomeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,ValueClickDelegate,UITextFieldDelegate>
{
    //AdvertisingColumn *_headerView;

    AOScrollerView *_myheaderView;
    UIView *_mySeparateView;
    NSMutableArray * _SeachMutArr;
    NSMutableArray * _ResultMutArr;
}


@property (nonatomic,strong)UICollectionView *collectionView;
//@property (nonatomic,strong)UICollectionView *btncollectionView;
@end
