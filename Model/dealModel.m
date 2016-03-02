//
//  dealModel.m
//  团购项目
//
//  Created by lb on 15/7/20.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import "dealModel.h"

@implementation dealModel


- (NSArray *)asignModelWithDict:(NSDictionary *)dict{

    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            dealModel *NM=[[dealModel alloc]init];
            NM.title = dict[@"goodsTitle"];
            NM.price = dict[@"goodsPrice"];
            NM.imageurl=dict[@"goodsPicUrl"];
            NM.dealurl=dict[@"goodsInfoMobileUrl"];
            [arr addObject:NM];
        }
    }
    return arr;
}


@end
