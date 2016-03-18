//
//  sortModel.m
//  caidao
//
//  Created by tianan-apple on 16/3/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "sortModel.h"
#import "MultilevelMenu.h"
@implementation sortModel
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *datadict = [dict objectForKey:@"data"];
    NSDictionary *typedict = [datadict objectForKey:@"type"];
    

    
    for (NSDictionary *dict in typedict) {
       
        rightMeun * meun=[[rightMeun alloc] init];
        
        
        meun.meunName=[dict objectForKey:@"typeName"];//左侧列表
        meun.ID=[dict objectForKey:@"typeId"];
        meun.urlName=@"http://img10.360buyimg.com/n7/jfs/t2545/339/1086011859/115096/15e03bf4/568485f2Nb0f80f1f.jpg";
        
        rightMeun * meun1=[[rightMeun alloc] init];
        meun1.meunName=[dict objectForKey:@"typeName"];//右侧标题
        meun1.urlName=@"http://img10.360buyimg.com/n7/jfs/t2545/339/1086011859/115096/15e03bf4/568485f2Nb0f80f1f.jpg";
        
        NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
        [sub addObject:meun1];
        meun.nextArray=sub;
        
        NSDictionary *subdict = [dict objectForKey:@"brands"];
       
        NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *mydict in subdict)
        {
            rightMeun * subMeun=[[rightMeun alloc] init];
            subMeun.meunName=[mydict objectForKey:@"name"];//右侧详细
            subMeun.ID=[mydict objectForKey:@"name"];
            subMeun.urlName=@"http://img10.360buyimg.com/n7/jfs/t2545/339/1086011859/115096/15e03bf4/568485f2Nb0f80f1f.jpg";
            [zList addObject:subMeun];
        }
         meun1.nextArray=zList;
       
        meun.nextArray=sub;
        [arr addObject:meun];
    }
    return arr;
}

@end
