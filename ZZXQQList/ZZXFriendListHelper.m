//
//  ZZXFriendListHelper.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXFriendListHelper.h"

@interface ZZXFriendListHelper ()
@property (nonatomic, strong) NSMutableArray *friendGrounps;
@end

@implementation ZZXFriendListHelper

- (NSMutableArray *)friendGrounps {
    if (_friendGrounps == nil) {
        _friendGrounps = [NSMutableArray array];
    }
    return _friendGrounps;
}

- (instancetype)initWithJsonData:(id)json {
    if (self = [super init]) {
        NSArray *tmpArray = json;
        for (NSDictionary *dic in tmpArray) {
            ZZXFriendGroup *group = [[ZZXFriendGroup alloc] initWithDict:dic];
            [self.friendGrounps addObject:group];
        }
    }
    return self;
}

- (NSInteger)numbersOfGroups {
    return self.friendGrounps.count;
}

- (ZZXFriendGroup *)grounpAtIndex:(NSInteger)index {
    if (index < self.friendGrounps.count) {
        return self.friendGrounps[index];
    }
    else{
        return nil;
    }
}

@end
