//
//  sortDealViewController.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/11/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sortDealViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIButton *sortTopBtn;
-(void)setSortListId:(NSString *)sortListId;
-(void)setTopTitle:(NSString *)topTitle;
@end
