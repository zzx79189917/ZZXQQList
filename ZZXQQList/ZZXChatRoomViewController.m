//
//  ZZXChatRoomViewController.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/24.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXChatRoomViewController.h"
#import <MJRefresh.h>

@interface ZZXChatRoomViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableview;
@property (nonatomic, strong) NSMutableArray *chatRecorder;
@end

@implementation ZZXChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天记录";
    self.chatRecorder = [NSMutableArray array];
    [self.chatRecorder addObject:self.totalChatArray[0]];
    self.mainTableview = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.mainTableview.delegate = self;
    self.mainTableview.dataSource = self;
    self.mainTableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.mainTableview];
    
    [self.mainTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"chat"];
    __weak typeof(self) weakSelf = self;
    self.mainTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.chatRecorder.count<self.totalChatArray.count) {
            [self.chatRecorder addObject:self.totalChatArray[self.chatRecorder.count]];
        }
        [weakSelf.mainTableview reloadData];
        [weakSelf.mainTableview.mj_header endRefreshing];
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatRecorder.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chat" forIndexPath:indexPath];
    cell.textLabel.text = self.chatRecorder[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
