//
//  ZZXFriendListController.h
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXBaseViewController.h"

@interface ZZXFriendListController : ZZXBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *friendList;
@end
