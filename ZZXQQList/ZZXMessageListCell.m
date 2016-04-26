//
//  ZZXMessageListCell.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXMessageListCell.h"
#import <Masonry.h>

@implementation ZZXMessageListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews{
    self.avatar = [[UIImageView alloc]init];
    self.avatar.layer.cornerRadius = 30;
    [self addSubview:self.avatar];
    
    self.nickName = [[UILabel alloc]init];
    self.nickName.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.nickName];
    
    self.lastSentence = [[UILabel alloc]init];
    self.lastSentence.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.lastSentence];
    
    self.lastTime = [[UILabel alloc]init];
    [self addSubview:self.lastTime];
    
    self.messageCount = [[UILabel alloc]init];
    self.messageCount.backgroundColor = [UIColor redColor];
    self.messageCount.textColor = [UIColor whiteColor];
    self.messageCount.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.messageCount];
    
    
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.equalTo(@60);
    }];
    
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(5);
        make.top.equalTo(self.avatar);
    }];
    
    [self.lastSentence mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickName);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [self.lastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_top);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    [self.messageCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lastTime.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
}



@end
