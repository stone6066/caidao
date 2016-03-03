//
//  NewsTableViewCell.h
//  caidao
//
//  Created by tianan-apple on 16/3/3.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class dealModel;
@interface NewsTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *NewsTitle;
@property(nonatomic,strong)UIImageView *NewsImage;
@property(nonatomic,copy)NSString *dealUrl;

-(void)showUiNewsCell:(dealModel*)NModel;
-(dealModel*)praseModelWithCell:(NewsTableViewCell *)cell;
@end
