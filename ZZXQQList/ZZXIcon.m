//
//  ZZXIcon.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXIcon.h"
#import <Masonry.h>

@implementation ZZXIcon

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth/4-10, kScreenWidth/4-10)];
        [self addSubview:self.iconImageView];
        self.iconTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame), kScreenWidth/4, 20)];
        self.iconTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.iconTitleLabel];
    }
    return self;
}

@end
