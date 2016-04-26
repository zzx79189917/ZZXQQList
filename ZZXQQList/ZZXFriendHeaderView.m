//
//  ZZXFriendHeaderView.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXFriendHeaderView.h"
#import "ZZXIcon.h"
#import <Masonry.h>

@implementation ZZXFriendHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UISearchBar *search = [[UISearchBar alloc]init];
        [self addSubview:search];
        UIView *bgView = [[UIView alloc]init];
        [self addSubview:bgView];
        [search mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.height.equalTo(@30);
        }];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(search.mas_bottom).offset(0);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        ZZXIcon *newFriend = [[ZZXIcon alloc]initWithFrame:CGRectMake(0, search.frame.size.height, screenWidth/4, bgView.frame.size.height)];
        newFriend.iconImageView.image = [UIImage imageNamed:@"qqstar1"];
        newFriend.iconTitleLabel.text = @"新朋友";
        [bgView addSubview:newFriend];
        
        ZZXIcon *special = [[ZZXIcon alloc]initWithFrame:CGRectMake(screenWidth/4, search.frame.size.height, screenWidth/4, bgView.frame.size.height)];
        special.iconImageView.image = [UIImage imageNamed:@"qqstar2"];
        special.iconTitleLabel.text = @"特别关注";
        [bgView addSubview:special];
        
        ZZXIcon *group = [[ZZXIcon alloc]initWithFrame:CGRectMake(screenWidth/2, search.frame.size.height, screenWidth/4, bgView.frame.size.height)];
        group.iconImageView.image = [UIImage imageNamed:@"qqstar3"];
        group.iconTitleLabel.text = @"群组";
        [bgView addSubview:group];
        
        ZZXIcon *public = [[ZZXIcon alloc]initWithFrame:CGRectMake(screenWidth*3/4, search.frame.size.height, screenWidth/4, bgView.frame.size.height)];
        public.iconImageView.image = [UIImage imageNamed:@"qqstar4"];
        public.iconTitleLabel.text = @"公众号";
        [bgView addSubview:public];
        
        
    }
    return self;
}

@end
