//
//  ZZXFriendModel.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXFriendModel.h"

@implementation ZZXFriendModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self= [super init];
    if (self) {
        self.followStatus = dic[@"followStatus"];
        self.subscriptNum = dic[@"subscriptionNum"];
        self.intro = dic[@"intro"];
        self.avatarUrl = dic[@"avatar"];
        self.nickName = dic[@"nickname"];
        self.friendId = dic[@"id"];
    }
    return self;
}

@end
