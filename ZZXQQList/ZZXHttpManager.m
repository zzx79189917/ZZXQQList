//
//  ZZXHttpManager.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXHttpManager.h"
#import "ZZXFriendListHelper.h"

@implementation ZZXHttpManager

+ (NSURLSessionDataTask *)requestAsynchronousWithURL :(NSString*)url withParameters:(NSDictionary*)param withRequestMethod:(NSString *)method customHandle:(void (^)(id result))success failureHandle:(void(^)(NSError *error))failed{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:param];
    [dictionary addEntriesFromDictionary:[self appendCustonDic]];
    
    NSURLSessionDataTask *dataTask = nil;
    void (^successBlock)(id task, id responseObject) = ^(id task, id responseObject){
        success(responseObject);
    };
    void (^failureBlock)(id task, NSError *error) = ^(id task, NSError *error){
        failed(error);
        NSLog(@"request error = %@",error);
        if(![self isNetworkingReachability])
            NSLog(@"当前网络不可用");
        else
            NSLog(@"请求出错啦！");
    };
    if ([method isEqualToString:@"GET"]){
        dataTask = [[AFHTTPSessionManager manager] GET:url parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            success(responseObject);
        } failure:failureBlock];
    }else if([method isEqualToString:@"POST"]){
        dataTask =  [AFHTTPSessionManager.manager POST:url parameters:dictionary progress:nil success:successBlock failure:failureBlock];;
    }
    return dataTask;
}

+ (BOOL)isNetworkingReachability
{
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    return afNetworkReachabilityManager.isReachable;
}

+ (NSMutableDictionary *)appendCustonDic{
    return [NSMutableDictionary dictionary];
}

@end
