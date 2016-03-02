//
//  DPRequest.m
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

/*
 ***数据缓存机制
 ***进入app，判断距离上次刷新数据的时间间隔是否大于3天，如果大于3天，刷新数据，否则读取缓存。
 ***下拉刷新，强制刷新数据，包括之后的上拉刷新也是立即刷新数据，不去读取缓存。
 ***其余是先读取缓存，如果有缓存，直接读取缓存，否则立即刷新数据。
 */

#import "DPRequest.h"
#import "DPConstants.h"
#import "DPAPI.h"

#import <CommonCrypto/CommonDigest.h>

#import "Reachability.h"
#import "PublicDefine.h"

#define kDPRequestTimeOutInterval   180.0
#define kDPRequestStringBoundary    @"9536429F8AAB441bA4055A74B72B57DE"

@interface DPAPI ()
- (void)requestDidFinish:(DPRequest *)request;
@end

@interface DPRequest () <NSURLConnectionDelegate>

@end

@implementation DPRequest {
    NSURLConnection                 *_connection;
    NSMutableData                   *_responseData;
    NSString *mainUrl;
}

#pragma mark - Private Methods

- (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString {
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
		
		if ([elements count] <= 1) {
			return nil;
		}
		
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

- (NSMutableData *)postBodyHasRawData:(BOOL*)hasRawData
{
	return nil;
}

- (void)handleResponseData:(NSData *)data
{
//    if ([_delegate respondsToSelector:@selector(request:didReceiveRawData:)])
//    {
//        [_delegate request:self didReceiveRawData:data];
//    }
    
#warning 去除对SBJson的依赖
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //NSLog(@"*******:%@",result);
    if (result == nil) {
		[self failedWithError:error];
	} else {
		NSString *status = 0;
        if([result isKindOfClass:[NSDictionary class]])
        {
            status = [result objectForKey:@"msg"];
            //datastr= [result objectForKey:@"data"];
            //status = [result objectForKey:@"auditStatus"];
            //NSLog(@"####:%@",status);
        }
//        if ([_delegate respondsToSelector:@selector(request:didFinishLoadingWithResult:)])
//        {
//            [_delegate request:self didFinishLoadingWithResult:(result == nil ? data : result)];
//        }
		if ([status isEqualToString:@"ok"]) {
			if ([_delegate respondsToSelector:@selector(request:didFinishLoadingWithResult:)])
			{
				[_delegate request:self didFinishLoadingWithResult:(result == nil ? data : result)];
			}
		} else {
			if ([status isEqualToString:@"ERROR"]) {
				// TODO: 处理错误代码
#warning 增加错误处理
                NSDictionary *errorDict = result[@"error"];
                int errorCode = [errorDict[@"errorCode"] intValue];
                NSString *errorMessage = errorDict[@"errorMessage"];
                NSError *error = [NSError errorWithDomain:errorMessage code:errorCode userInfo:errorDict];
                [self failedWithError:error];
			}
		}
	}
}

- (void)handleResponseDataType:(NSData *)data
{
//    if ([_delegate respondsToSelector:@selector(request:didReceiveRawData:)])
//    {
//        [_delegate typerequest:self didReceiveRawData:data];
//    }
    
#warning 去除对SBJson的依赖
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //NSLog(@"*******:%@",result);
    if (result == nil) {
        [self failedWithError:error];
    } else {
        NSString *status = 0;
        if([result isKindOfClass:[NSDictionary class]])
        {
            status = [result objectForKey:@"msg"];
        }
        if ([_delegate respondsToSelector:@selector(typerequest:didFinishLoadingWithResult:)])
        {
            [_delegate typerequest:self didFinishLoadingWithResult:(result == nil ? data : result)];
        }
       
    }
}

- (void)handleResponseDataLogin:(NSData *)data
{
//    if ([_delegate respondsToSelector:@selector(loginrequest:didReceiveRawData:)])
//    {
//        [_delegate loginrequest:self didReceiveRawData:data];
//    }
    
#warning 去除对SBJson的依赖
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //NSLog(@"*******:%@",result);
    if (result == nil) {
        [self failedWithError:error];
    } else {
        NSString *status = 0;
        if([result isKindOfClass:[NSDictionary class]])
        {
            status = [result objectForKey:@"msg"];
        }
        if ([_delegate respondsToSelector:@selector(loginrequest:didFinishLoadingWithResult:)])
        {
            [_delegate loginrequest:self didFinishLoadingWithResult:(result == nil ? data : result)];
        }
        
    }
}

//- (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo
//{
//    
//    return [NSError errorWithDomain:@"123" code:code userInfo:userInfo];
//}

- (void)failedWithError:(NSError *)error
{
	if ([_delegate respondsToSelector:@selector(request:didFailWithError:)])
	{
		[_delegate request:self didFailWithError:error];
	}
}

#pragma mark - Public Methods

+ (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName
{
    if (![paramName hasSuffix:@"="])
    {
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    
    NSString * str = nil;
    NSRange start = [url rangeOfString:paramName];
    if (start.location != NSNotFound)
    {
        // confirm that the parameter is not a partial name match
        unichar c = '?';
        if (start.location != 0)
        {
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#')
        {
            NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
            NSUInteger offset = start.location+start.length;
            str = end.location == NSNotFound ?
            [url substringFromIndex:offset] :
            [url substringWithRange:NSMakeRange(offset, end.location)];
            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    return str;
}
-(NSDictionary *)stdParseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        
        if ([elements count] <= 1) {
            return nil;
        }
        
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

-(NSString *)stdMakeUrlWithParas:(NSString *)baseURL params:(NSDictionary *)params{
    NSURL* parsedURL = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[self stdParseQueryString:[parsedURL query]]];
    if (params) {
        [paramsDic setValuesForKeysWithDictionary:params];
    }
    NSMutableString *paramsString = [[NSMutableString alloc]init];
    NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
    for (NSString *key in sortedKeys) {
        [paramsString appendFormat:@"&%@=%@", key, [paramsDic objectForKey:key]];
    }
    
    NSString *potrstr=[[parsedURL port]stringValue];
    if (potrstr.length>0) {
        return [NSString stringWithFormat:@"%@://%@:%@%@?%@", [parsedURL scheme], [parsedURL host], [parsedURL port],[parsedURL path], [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
        return [NSString stringWithFormat:@"%@://%@%@?%@", [parsedURL scheme], [parsedURL host], [parsedURL path], [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
	NSURL* parsedURL = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
	NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[self parseQueryString:[parsedURL query]]];
	if (params) {
		[paramsDic setValuesForKeysWithDictionary:params];
	}
	NSMutableString *paramsString = [[NSMutableString alloc]init];
	NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
	for (NSString *key in sortedKeys) {
		[paramsString appendFormat:@"&%@=%@", key, [paramsDic objectForKey:key]];
	}
    
    //return [NSString stringWithFormat:@"%@%@",baseURL,paramsString];
    //NSLog(@"scheme:%@   host:%@   path:%@",[parsedURL scheme], [parsedURL host], [parsedURL path]);
//     NSString *mainUrl=[NSString stringWithFormat:@"%@://%@:%@",[parsedURL scheme], [parsedURL host], [parsedURL port]];
    //
    NSString *potrstr=[[parsedURL port]stringValue];
    if (potrstr.length>0) {
        return [NSString stringWithFormat:@"%@://%@:%@%@?%@", [parsedURL scheme], [parsedURL host], [parsedURL port],[parsedURL path], [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
     return [NSString stringWithFormat:@"%@://%@%@?%@", [parsedURL scheme], [parsedURL host], [parsedURL path], [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
}

+ (DPRequest *)requestWithURL:(NSString *)url
                              params:(NSDictionary *)params
                            delegate:(id<DPRequestDelegate>)delegate
{
    DPRequest *request = [[DPRequest alloc] init];
    
    request.url = url;
    request.params = params;
    request.delegate = delegate;
    
    return request;
}

- (void)connect
{
   
    NSString* urlString = [[self class] serializeURL:_url params:_params];
    
    //NSString* urlString =@"http://192.168.0.11:8080/nct/common.htm?&logInfoType=1&pageNo=1&pageSize=15&ut=loginfo";
    NSLog(@"urlString:%@",urlString);
    NSMutableURLRequest* request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
                            //cachePolicy:NSURLRequestReturnCacheDataElseLoad
                        //timeoutInterval:kDPRequestTimeOutInterval];
    
    
    
    [request setHTTPMethod:@"GET"];
    
   
    
    //=====缓存机制==================
   
//    
//    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    NSURLCache *cache = [NSURLCache sharedURLCache];
    if ([_myAllwaysFlash isEqualToString: @"1"]) {//列表上拉强制刷新
        [self setDataLastUpdateTime];
        [cache removeCachedResponseForRequest:request];
    }
    else
    {
        _myAllwaysFlash=[self getDataRefreshDateLong];
         if ([_myAllwaysFlash isEqualToString: @"1"]){//缓存已经超过3天，立即更新数据
            [cache removeCachedResponseForRequest:request];
        }
        else
            request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
   
    
    NSCachedURLResponse *response = [cache cachedResponseForRequest:request];
    if (response) {
        NSLog(@"---这个请求已经存在缓存");
    } else {
        NSLog(@"---这个请求没有缓存");
    }
    
   [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            //NSLog(@"接收的数据：%@",data);
            [self handleResponseData:data];
        }
       if (connectionError) {
           //[_delegate request:self didFailWithError:connectionError];
       }
    }];
    
}

+ (NSString *)serializeparams:(NSDictionary *)params
{
        NSMutableString *paramsString = [[NSMutableString alloc]init];
   
    for (NSString *key in params) {
        [paramsString appendFormat:@"&%@=%@", key, [params objectForKey:key]];
    }
    
    return paramsString;
   
    
}

- (void)postConnect
{
    NSString* paramString = [[self class] serializeparams:_params];
//    //urlString= [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSMutableURLRequest* request =
//    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
//                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                        timeoutInterval:kDPRequestTimeOutInterval];
//    
//    [request setHTTPMethod:@"POST"];
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:NetUrl];//不需要传递参数
    
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=paramString;
   // @"&areaId=8&typeId=2&brandId=30&origin=Wee&price=4&unit=斤&ut=priceadd&typeName=水果&brandName=南丰蜜桔&priceDesc=Rrrrrrr&areaName=永宁县";
    //paramString;
    //[NSString stringWithFormat:@"username=%@&pwd=%@",self.username.text,self.pwd.text];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    //    3.发送请求
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}


- (void)typeConnect
{
    NSString* urlString = [[self class] serializeURL:_url params:_params];
    
    //NSString* urlString =@"http://192.168.0.11:8080/nct/common.htm?&logInfoType=1&pageNo=1&pageSize=15&ut=loginfo";
    NSLog(@"urlString:%@",urlString);
    NSMutableURLRequest* request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    
    
    //=====缓存机制==================
    
    //
    //    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    NSURLCache *cache = [NSURLCache sharedURLCache];
    if ([_myAllwaysFlash isEqualToString: @"1"]) {//列表上拉强制刷新
        [self setDataLastUpdateTime];
        [cache removeCachedResponseForRequest:request];
    }
    else
    {
        _myAllwaysFlash=[self getDataRefreshDateLong];
        if ([_myAllwaysFlash isEqualToString: @"1"]){//缓存已经超过3天，立即更新数据
            [cache removeCachedResponseForRequest:request];
        }
        else
            request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    
    
    NSCachedURLResponse *response = [cache cachedResponseForRequest:request];
    if (response) {
        NSLog(@"---这个请求已经存在缓存");
    } else {
        NSLog(@"---这个请求没有缓存");
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            //NSLog(@"接收的数据：%@",data);
            [self handleResponseDataType:data];
        }
        if (connectionError) {
            //[_delegate request:self didFailWithError:connectionError];
        }
    }];

//    NSString* urlString = [[self class] serializeURL:_url params:_params];
//    
//    NSLog(@"urlString:%@",urlString);
//    NSMutableURLRequest* request =
//    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"GET"];
//
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (data) {
//            //NSLog(@"接收的数据：%@",data);
//            [self handleResponseDataType:data];
//        }
//        if (connectionError) {
//            
//        }
//    }];
    
}

- (void)loginConnect
{
    
        NSString* urlString = [[self class] serializeURL:_url params:_params];
    
        NSLog(@"urlString:%@",urlString);
        NSMutableURLRequest* request =
        [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"GET"];
    
    
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                //NSLog(@"接收的数据：%@",data);
                [self handleResponseDataLogin:data];
            }
            if (connectionError) {
                
            }
        }];
    
}

- (void)disconnect
{
	_responseData = nil;
    
    [_connection cancel];
    _connection = nil;
}


#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	_responseData = [[NSMutableData alloc] init];
    //NSLog(@"-------:%@",response);
	if ([_delegate respondsToSelector:@selector(request:didReceiveResponse:)])
    {
		[_delegate request:self didReceiveResponse:response];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   // NSLog(@"+++++++:%@",data);
    
	[_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
	[self handleResponseData:_responseData];
    
	_responseData = nil;
    
    [_connection cancel];
	_connection = nil;
    
    [_dpapi requestDidFinish:self];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	[self failedWithError:error];
	
	_responseData = nil;
    
    [_connection cancel];
	_connection = nil;
    
    [_dpapi requestDidFinish:self];
    
}

#pragma mark - Life Circle
- (void)dealloc
{
    [_connection cancel];
	_connection = nil;
}

NSString *const DataRefreshLastTime = @"dataRefreshLastTime";
#pragma mark - 状态相关
#pragma mark 设置最后的更新时间
- (void)setDataLastUpdateTime
{
    // 保存最后更新时间
    NSInteger netFlag=[self getCurrNetstate];
    if (netFlag>0) {//网络通畅，可以访问
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:DataRefreshLastTime];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(NSDate *)getHomeLastUpdateTime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:DataRefreshLastTime];
}

-(NSString *)getDataRefreshDateLong{
    NSDate *cmp1=[self getHomeLastUpdateTime];
    if (cmp1) {
        NSDate *cmp2=[NSDate date];
        //NSLog(@"刷新间隔：%f",fabs([cmp2 timeIntervalSinceDate:cmp1]));
        if (fabs([cmp1 timeIntervalSinceDate:cmp2])>3*24*3600)//更新时间大于3天，重新下载缓存
        {
            [self setDataLastUpdateTime];
            return @"1";
        }
        else
            return @"0";
    }
    else
    {
        [self setDataLastUpdateTime];
        return @"1";
    }
}

-(NSInteger)getCurrNetstate{
    Reachability *r = [Reachability reachabilityWithHostName:MainUrl];
    switch ([r currentReachabilityStatus]) {
    case NotReachable:
        // 没有网络连接
            return -1;
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
@end



