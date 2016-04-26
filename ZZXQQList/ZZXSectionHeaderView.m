//
//  ZZXSectionHeaderView.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXSectionHeaderView.h"
#import <Masonry.h>

@implementation ZZXSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews{
    self.arrowImageView = [[UIImageView alloc]init];
    self.arrowImageView.contentMode = UIViewContentModeCenter;
    self.arrowImageView.image = [UIImage imageNamed:@"closeArrow"];
    [self addSubview:self.arrowImageView];
    
    self.groupName = [[UILabel alloc]init];
    [self addSubview:self.groupName];
    
    self.statusCount = [[UILabel alloc]init];
    [self addSubview:self.statusCount];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.equalTo(@50);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.groupName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.arrowImageView.mas_right).offset(-5);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [self.statusCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
}

@end
