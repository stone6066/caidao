//
//  ShopViewCell.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/15.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class dealModel;

@interface ShopViewCell : UICollectionViewCell

- (void)showUIWithModel:(dealModel *)model;
-(dealModel*)praseModelWithCell:(ShopViewCell *)cell;
@end
