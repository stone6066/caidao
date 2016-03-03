//
//  NewsTableViewCell.m
//  caidao
//
//  Created by tianan-apple on 16/3/3.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "dealModel.h"
#import "UIImageView+WebCache.h"
#import "PublicDefine.h"
@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat CellWidth= fDeviceWidth-20;
        
        _NewsImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, CellWidth, 150)];
        [self addSubview:_NewsImage];
        
        _NewsTitle=[[UILabel alloc]initWithFrame:CGRectMake(10,150,CellWidth,40)];
        _NewsTitle.font=[UIFont systemFontOfSize:15];
        [self addSubview:_NewsTitle];

    }
    return self;
}

-(void)showUiNewsCell:(dealModel*)NModel{
    _NewsTitle.text=NModel.title;
    [_NewsImage sd_setImageWithStr:NModel.imageurl];
    _dealUrl=NModel.dealurl;
}

-(dealModel*)praseModelWithCell:(NewsTableViewCell *)cell{
    dealModel *nm = [[dealModel alloc]init];
    nm.dealurl=cell.dealUrl;
    
    return nm;
}
@end
