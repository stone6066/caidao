//
//  dealModel.h
//  团购项目
//
//  Created by lb on 15/7/20.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dealModel : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *imageurl;
@property (nonatomic,copy)NSString *dealurl;

- (NSArray *)asignModelWithDict:(NSDictionary *)dict;



/*
 businesses =             (
 );
 categories =             (
 KTV
 );
 city = "\U5168\U56fd";
 "commission_ratio" = 0;
 "current_price" = "38.8";
 "deal_h5_url" = "http://lite.m.dianping.com/qJCdiLiYyz";
 "deal_id" = "0-12731260";
 "deal_url" = "http://dpurl.cn/p/GFh1gq35fk";
 description = "\U5929\U9a6c\U97f3\U4e50\U8336\U5ea7 \U4ec5\U552e38.8\U5143\Uff0c\U4ef7\U503c150\U5143\U4e0b\U5348\U573a3\U5c0f\U65f6\U6b22\U5531\Uff0c\U53ef\U8fde\U7eed\U6b22\U5531\Uff0c\U514d\U5f00\U673a\U8d39\Uff0c\U514d\U8d39wifi\Uff01\U514d\U8d39\U505c\U8f66\U4f4d\Uff0c\U542b\U7acb\U9ea6\Uff01";
 distance = "-1";
 "image_url" = "http://t1.dpfile.com/pc/mc/fce72445167b671151b45e0f5f8be8de(640x1024)/thumb.jpg";
 "list_price" = 150;
 "publish_date" = "2015-07-07";
 "purchase_count" = 0;
 "purchase_deadline" = "2016-12-31";
 regions =             (
 );
 "s_image_url" = "http://t3.dpfile.com/pc/mc/fce72445167b671151b45e0f5f8be8de(640x1024)/thumb_1.jpg";
 title = "\U5929\U9a6c\U97f3\U4e50\U8336\U5ea7";
 },
 */

@end
