//
//  DPAPI.m
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import "DPAPI.h"
#import "DPConstants.h"
#import "Reachability.h"
#import "stdPubFunc.h"
#import "PublicDefine.h"

@interface DPAPI (Private)

@end


@implementation DPAPI {
	NSMutableSet *requests;
}

-(void)setAllwaysFlash:(NSString *)allwaysFlash
{
    _allwaysFlash=allwaysFlash;
}

- (id)init {
	self = [super init];
    if (self) {
        requests = [[NSMutableSet alloc] init];
    }
    return self;
}

- (DPRequest*)typeRequestWithURL:(NSString *)url
                      params:(NSMutableDictionary *)params
                    delegate:(id<DPRequestDelegate>)delegate {
    if ([self GetNetState]==0) {
        [stdPubFunc stdShowMessage:@"当前网络不给力，请联网后操作"];
        return nil;
    }
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    NSString *fullURL = url;//[kDPAPIDomain stringByAppendingString:url];
    DPRequest *_request = [DPRequest requestWithURL:fullURL
                                             params:params
                                           delegate:delegate];
    _request.dpapi = self;
    _request.myAllwaysFlash=_allwaysFlash;
    
    [requests addObject:_request];
    [_request typeConnect];
    return _request;
}
- (DPRequest*)loginRequestWithURL:(NSString *)url
                           params:(NSMutableDictionary *)params
                         delegate:(id<DPRequestDelegate>)delegate {
    if ([self GetNetState]==0) {
        [stdPubFunc stdShowMessage:@"当前网络不给力，请联网后操作"];
        return nil;
    }
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    NSString *fullURL = url;//[kDPAPIDomain stringByAppendingString:url];
    DPRequest *_request = [DPRequest requestWithURL:fullURL
                                             params:params
                                           delegate:delegate];
    _request.dpapi = self;
    _request.myAllwaysFlash=_allwaysFlash;
    
    [requests addObject:_request];
    [_request loginConnect];
    return _request;
}

- (DPRequest*)requestWithURL:(NSString *)url
					  params:(NSMutableDictionary *)params
					delegate:(id<DPRequestDelegate>)delegate {
    if ([self GetNetState]==0) {
        [stdPubFunc stdShowMessage:@"当前网络不给力，请联网后操作"];
        return nil;
    }
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    NSString *fullURL = url;//[kDPAPIDomain stringByAppendingString:url];
    //NSString *fullURL = kDPAPIDomain;
	DPRequest *_request = [DPRequest requestWithURL:fullURL
											 params:params
										   delegate:delegate];
	_request.dpapi = self;
    _request.myAllwaysFlash=_allwaysFlash;
    
	[requests addObject:_request];
	[_request connect];
	return _request;
}

- (DPRequest*)postRequestWithURL:(NSString *)url
                      params:(NSMutableDictionary *)params
                    delegate:(id<DPRequestDelegate>)delegate {
    if ([self GetNetState]==0) {
        [stdPubFunc stdShowMessage:@"当前网络不给力，请联网后操作"];
        return nil;
    }
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    NSString *fullURL = url;//[kDPAPIDomain stringByAppendingString:url];
    //NSString *fullURL = kDPAPIDomain;
    DPRequest *_request = [DPRequest requestWithURL:fullURL
                                             params:params
                                           delegate:delegate];
    _request.dpapi = self;
    _request.myAllwaysFlash=_allwaysFlash;
    
    [requests addObject:_request];
    [_request postConnect];
    return _request;
}


- (DPRequest *)requestWithURL:(NSString *)url
				 paramsString:(NSString *)paramsString
					 delegate:(id<DPRequestDelegate>)delegate {
	return [self requestWithURL:[NSString stringWithFormat:@"%@?%@", url, paramsString] params:nil delegate:delegate];
}




- (void)requestDidFinish:(DPRequest *)request
{
    [requests removeObject:request];
    request.dpapi = nil;
}

- (void)dealloc
{
    for (DPRequest* _request in requests)
    {
        _request.dpapi = nil;
    }
}
-(NSInteger)GetNetState{
    
    Reachability *r = [Reachability reachabilityWithHostName:MainUrl];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            return 0;
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            return 1;
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            return 2;
            break;
    }
}

+(NSString *)stdMakeUrlWithParas:(NSString *)baseURL params:(NSDictionary *)params{
   return  [DPRequest serializeURL:baseURL params:params];
}

@end
