//
//  ZZXFriendModel.h
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXBaseModel.h"

@interface ZZXFriendModel : ZZXBaseModel
@property (nonatomic, copy) NSNumber *followStatus;
@property (nonatomic, copy) NSString *subscriptNum;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *friendId;
- (instancetype)initWithDic:(NSDictionary *)dic;
//followStatus: false,
//subscriptionNum: "1183",
//intro: "国金证券策略研究李立峰团队研究报告发布和交流平台,欢迎交流!",
//avatar: "http://posts.cdn.wallstcn.com/e4/42/c8/243110454432623041.jpg",
//nickname: "国金策略李立峰团队",
//id: "175"
@end
