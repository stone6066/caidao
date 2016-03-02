//
//  HomeCollectionViewCell.h
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/23.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class dealModel;

@protocol ShortCutdelegate <NSObject>
@optional
- (void)shortCutClick:(NSInteger)sendTag;
@end

@interface HomeCollectionViewCell : UICollectionViewCell
//@property(nonatomic ,strong)UIImageView *imgView;
//@property(nonatomic ,strong)UILabel *title;
//@property(nonatomic ,strong)UILabel *detail;
//@property(nonatomic ,strong)UILabel *oldPrice;
//@property(nonatomic ,strong)UILabel *currPrice;
//@property (nonatomic,copy)NSString *deal_id;
//
//- (void)showUIWithModel:(dealModel *)model;
//-(dealModel*)praseModelWithCell:(HomeCollectionViewCell *)cell;
{
    UIView *_backView1;
    UIView *_backView2;
    UIPageControl *_pageControl;
}
@property (nonatomic, unsafe_unretained) id<ShortCutdelegate> delegate;

@end


