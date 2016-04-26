//
//  ZZXFriendListHelper.h
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXBaseModel.h"
#import "ZZXFriendGroup.h"

@interface ZZXFriendListHelper : ZZXBaseModel
- (instancetype)initWithJsonData:(id)json;

- (NSInteger)numbersOfGroups;
- (ZZXFriendGroup *)grounpAtIndex:(NSInteger)index;

@end
