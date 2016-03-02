//
//  SearchViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/30.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SearchViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIButton *serTopBtn;
@end
