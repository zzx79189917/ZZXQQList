//
//  ZZXFriendListController.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXFriendListController.h"
#import "ZZXFriendHeaderView.h"
#import "ZZXHttpManager.h"
#import "ZZXFriendListCell.h"
#import "ZZXFriendListHelper.h"
#import "ZZXSectionHeaderView.h"
#import <SDWebImageManager.h>
#import <MJRefresh.h>
#import <TMCache.h>

@interface ZZXFriendListController()

@property (nonatomic, strong) ZZXFriendListHelper *helper;
@property (nonatomic, strong) NSArray *netStatus;
@end

@implementation ZZXFriendListController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.friendList reloadData];
}

-(void)viewDidLoad{
    self.title = @"联系人";
    self.netStatus = @[@"2G",@"3G",@"4G",@"Wifi"];
    [ZZXHttpManager  requestAsynchronousWithURL:kZZXDataUrl withParameters:nil withRequestMethod:@"GET" customHandle:^(id result) {
        NSMutableArray *personalInfos = [NSMutableArray array];
        NSArray *groupArray = result;
        for (int i = 0; i<groupArray.count; i++) {
            NSArray *authors = groupArray[i][@"authors"];
            for (int j = 0; j<authors.count; j++) {
                NSDictionary *dic = [NSMutableDictionary dictionary];
            dic = @{
                     @"nickname":authors[j][@"nickname"],
                     @"id":authors[j][@"id"],
                     @"avatar":authors[j][@"avatar"]
                     };
                [personalInfos addObject:dic];
            }
        }
        [[TMCache sharedCache] setObject:personalInfos forKey:kUserDefaultPersonInfo];
        self.helper = [[ZZXFriendListHelper alloc] initWithJsonData:result];
        [self.friendList reloadData];
    } failureHandle:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    self.friendList = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.friendList.delegate = self;
    self.friendList.dataSource = self;
    self.friendList.tableFooterView= [[UIView alloc]init];
    [self.view addSubview:self.friendList];
    
    ZZXFriendHeaderView *header = [[ZZXFriendHeaderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    self.friendList.tableHeaderView = header;
    [self.friendList registerClass:[ZZXFriendListCell class] forCellReuseIdentifier:@"cell"];
    
    __weak typeof(self) weakSelf = self;
    self.friendList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.friendList reloadData];
        [weakSelf.friendList.mj_header endRefreshing];
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.helper numbersOfGroups];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZZXFriendGroup *grounp =[self.helper grounpAtIndex:section];
    return [grounp numbersOfFriends];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZXFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ZZXFriendGroup *group = [self.helper grounpAtIndex:indexPath.section];
    ZZXFriendModel *friend = [group friendAtIndex:indexPath.row];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:friend.avatarUrl] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.avatar.image = image;
    }];
    cell.nickName.text = friend.nickName;
    NSLog(@"%@",friend.followStatus);
    if ([friend.followStatus isEqualToNumber:@0]) {
        cell.status.text = @"【离线】";
    }else{
        cell.status.text = @"【在线】";
    }
    srand((unsigned)time(0));
    int i = arc4random() % 4;
    cell.netStatus.text = self.netStatus[i];
    cell.intro.text = friend.intro;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZZXFriendGroup *group = [self.helper grounpAtIndex:section];
    ZZXSectionHeaderView *btn = [[ZZXSectionHeaderView alloc]init];
    btn.tag = section;
    btn.frame = CGRectMake(0, 0, kScreenWidth, 0);
    [btn addTarget:self action:@selector(showOrHidde:) forControlEvents:UIControlEventTouchUpInside];
    btn.groupName.text = group.categoryName;
    NSUInteger onlineCount = 0;
    for (int i = 0; i<[group friendsCount]; i++) {
        ZZXFriendModel *friend = [group friendAtIndex:i];
        if (![friend.followStatus isEqualToNumber:@0]) {
            onlineCount ++;
        }
    }
    btn.statusCount.text = [NSString stringWithFormat:@"%ld/%ld",onlineCount,[group friendsCount]];
    return btn;
}

- (void)showOrHidde:(ZZXSectionHeaderView *)sender{
    ZZXFriendGroup *grounp = [self.helper grounpAtIndex:sender.tag];
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSLog(@"%ld",sender.tag);
    for (int i=0; i<grounp.friendsCount; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:sender.tag];
        [indexPaths addObject: index];
    }
    if (grounp.openOrClose == NO) {
        grounp.openOrClose = !grounp.openOrClose;
        [self.friendList insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        sender.arrowImageView.image = [UIImage imageNamed:@"oepnArrow"];
    }else{
        grounp.openOrClose = !grounp.openOrClose;
        [self.friendList deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        sender.arrowImageView.image = [UIImage imageNamed:@"closeArrow"];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
