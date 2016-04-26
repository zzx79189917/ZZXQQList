//
//  ZZXMessageListCell.h
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXBaseTableViewCell.h"

@interface ZZXMessageListCell : ZZXBaseTableViewCell
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *lastSentence;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *lastTime;
@property (nonatomic, strong) UILabel *messageCount;
@end
