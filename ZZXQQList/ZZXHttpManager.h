//
//  ZZXHttpManager.h
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface ZZXHttpManager : NSObject

+ (NSURLSessionDataTask *)requestAsynchronousWithURL :(NSString*)url withParameters:(NSDictionary*)param withRequestMethod:(NSString *)method customHandle:(void (^)(id result))success failureHandle:(void(^)(NSError *error))failed;

@end
