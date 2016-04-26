//
//  ZZXPhoneListCell.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/24.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXPhoneListCell.h"
#import <Masonry.h>

@implementation ZZXPhoneListCell

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
    
    self.status = [[UILabel alloc]init];
    self.status.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.status];
    
    self.netStatus = [[UILabel alloc]init];
    [self addSubview:self.netStatus];
    
    
    
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
    
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickName);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [self.netStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_top);
        make.right.equalTo(self.mas_right).offset(-5);
    }];

}

@end
