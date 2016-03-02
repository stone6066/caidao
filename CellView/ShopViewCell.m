//
//  ShopViewCell.m
//  StdTaoYXApp
//
//  Created by tianan-apple on 15/10/15.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "ShopViewCell.h"
#import "dealModel.h"
#import "UIImageView+WebCache.h"


@interface ShopViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UILabel *currPrice;

@property (weak, nonatomic) IBOutlet UILabel *biaojia;



@property (weak, nonatomic) IBOutlet UILabel *salesNumLabel;

@property (nonatomic,copy)NSString *deal_id;

@end

@implementation ShopViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)showUIWithModel:(dealModel *)model{
    self.titleLabel.text = model.title;
    self.currPrice.text = model.price;
    self.biaojia.text= @"¥: ";
    self.deal_id=model.dealurl;
    [self.imageView sd_setImageWithStr:model.imageurl];
}

-(dealModel*)praseModelWithCell:(ShopViewCell *)cell{
    dealModel *dm = [[dealModel alloc]init];
    dm.title=cell.titleLabel.text;
    
    dm.dealurl=cell.deal_id;
    return dm;
}

@end
