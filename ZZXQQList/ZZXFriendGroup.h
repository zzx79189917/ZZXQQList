//
//  ZZXFriendGroups.h
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXBaseModel.h"
#import "ZZXFriendModel.h"

@interface ZZXFriendGroup : ZZXBaseModel
@property (nonatomic, copy) NSNumber *groupId;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, assign) BOOL openOrClose;
@property (nonatomic, assign, readonly) NSInteger friendsCount;
- (NSInteger)numbersOfFriends;
- (ZZXFriendModel *)friendAtIndex:(NSInteger)index;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
