//
//  ZZXFriendGroups.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXFriendGroup.h"

@interface ZZXFriendGroup ()
@property (nonatomic, strong) NSMutableArray *friends;
@end

@implementation ZZXFriendGroup
- (NSMutableArray *)friends {
    if (_friends == nil) {
        _friends = [NSMutableArray array];
    }
    return _friends;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _categoryName = dict[@"category"][@"categoryName"];
        _groupId = dict[@"category"][@"id"];
        NSMutableArray *array = dict[@"authors"];
        for (NSDictionary *dic in array) {
            ZZXFriendModel *model = [[ZZXFriendModel alloc]initWithDic:dic];
            [self.friends addObject:model];
        }
    }
    return self;
}

- (NSInteger)friendsCount {
    return self.friends.count;
}

- (NSInteger)numbersOfFriends {
    if (self.openOrClose) {
        return self.friends.count;
    } else {
        return 0;
    }
}

- (ZZXFriendModel *)friendAtIndex:(NSInteger)index{
    if (index<self.friends.count) {
        return self.friends[index];
    }else{
        return nil;
    }
}
@end
