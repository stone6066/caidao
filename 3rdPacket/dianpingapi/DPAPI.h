//
//  DPAPI.h
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPRequest.h"

#define kDPAppKey             @"975791789"
//#define kDPAppKey             @"分类测试"
#define kDPAppSecret          @"5e4dcaf696394707b9a0139e40074ce9"

#ifndef kDPAppKey
#error
#endif

#ifndef kDPAppSecret
#error
#endif

@interface DPAPI : NSObject
@property(nonatomic,copy)NSString *allwaysFlash;
- (DPRequest*)requestWithURL:(NSString *)url
					  params:(NSMutableDictionary *)params
					delegate:(id<DPRequestDelegate>)delegate;
- (DPRequest*)typeRequestWithURL:(NSString *)url
                      params:(NSMutableDictionary *)params
                    delegate:(id<DPRequestDelegate>)delegate;

- (DPRequest *)requestWithURL:(NSString *)url
				 paramsString:(NSString *)paramsString
					 delegate:(id<DPRequestDelegate>)delegate;

- (DPRequest*)postRequestWithURL:(NSString *)url
                          params:(NSMutableDictionary *)params
                        delegate:(id<DPRequestDelegate>)delegate;

- (DPRequest*)loginRequestWithURL:(NSString *)url
                           params:(NSMutableDictionary *)params
                         delegate:(id<DPRequestDelegate>)delegate;

-(NSInteger)GetNetState;
+(NSString *)stdMakeUrlWithParas:(NSString *)baseURL params:(NSDictionary *)params;
@end
