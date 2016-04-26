//
//  ZZXMessageListController.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXMessageListController.h"
#import "ZZXPhoneListCell.h"
#import "ZZXMessageListCell.h"
#import "ZZXChatRoomViewController.h"
#import <Masonry.h>
#import <TMCache.h>
#import <SDWebImageManager.h>
#import <MJRefresh.h>

@interface ZZXMessageListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) NSUInteger seletedIndex;
@property (nonatomic, assign) NSUInteger messageCount;
@property (nonatomic, strong) NSMutableArray *cellArray;
@end

@implementation ZZXMessageListController

-(void)viewDidLoad{
    self.seletedIndex = 0;
    self.messageCount = 0;
    self.cellArray = self.cellArray = [[TMCache sharedCache] objectForKey:kUserDefaultMessageList];
    UISegmentedControl *segement = [[UISegmentedControl alloc]initWithItems:@[@"消息",@"电话"]];
    segement.selectedSegmentIndex = 0;
    [segement addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.navigationController.navigationBar.topItem.titleView = segement;
    
    UISearchBar *search = [[UISearchBar alloc]init];
    search.backgroundColor = [UIColor redColor];
    [self.view addSubview:search];
    
    self.mainTableView = [[UITableView alloc]init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(search.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.mainTableView registerClass:[ZZXPhoneListCell class] forCellReuseIdentifier:@"phone"];
    [self.mainTableView registerClass:[ZZXMessageListCell class] forCellReuseIdentifier:@"message"];
    
    NSNotificationCenter * center =[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(reciveNotice:) name:kNotificationName object:nil];
    
    __weak typeof(self) weakSelf = self;
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.mainTableView reloadData];
        [weakSelf.mainTableView.mj_header endRefreshing];
    }];
}

- (void)reciveNotice:(NSNotification *)noti{
    NSLog(@"------%f",self.tabBarController.tabBar.frame.origin.y);
    self.messageCount ++;
    NSArray *array = [NSArray arrayWithArray:[[TMCache sharedCache]objectForKey:kUserDefaultPersonInfo]];
    if (array.count >0) {
        NSUInteger num = arc4random()%array.count;
        NSDictionary *dic = [NSDictionary dictionary];
        dic = @{
                @"info":array[num],
                @"message":noti.userInfo[@"message"],
                @"time":noti.userInfo[@"time"],
                @"num":noti.userInfo[@"num"]
                };
        NSMutableArray *idMessageArray = [[TMCache sharedCache]objectForKey:dic[@"info"][@"id"]];
        if (!idMessageArray) {
            idMessageArray = [NSMutableArray array];
        }
        [idMessageArray insertObject:noti.userInfo[@"message"] atIndex:0];
        [[TMCache sharedCache]setObject:idMessageArray forKey:dic[@"info"][@"id"]];
        
        self.cellArray = [[TMCache sharedCache] objectForKey:kUserDefaultMessageList];
        if (!self.cellArray) {
            self.cellArray = [NSMutableArray array];
        }
        //
        BOOL buildNew = YES;
        for (int i = 0; i<self.cellArray.count; i++) {
            if ([dic[@"info"][@"id"] isEqualToString:self.cellArray[i][@"info"][@"id"] ])  {
                NSUInteger count = [self.cellArray[i][@"num"] integerValue] + 1;
                NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                mutableDic[@"num"] = [NSString stringWithFormat:@"%ld",count];
                
                [self.cellArray removeObjectAtIndex:i];
                [self.cellArray insertObject:mutableDic atIndex:0];
                buildNew = NO;
                break;
            }
        }
        if (buildNew == YES) {
            [self.cellArray insertObject:dic atIndex:0];
        }
        [[TMCache sharedCache]setObject:self.cellArray forKey:kUserDefaultMessageList];
        [self.mainTableView reloadData];
    }
    
}

-(void)changePage:(UISegmentedControl *)sender{
    self.seletedIndex = sender.selectedSegmentIndex;
    [self.mainTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.seletedIndex == 0) {
        return self.cellArray.count;
    }else if (self.seletedIndex == 1){
        return 5;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.seletedIndex == 0) {
        ZZXMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message" forIndexPath:indexPath];
        cell.nickName.text = self.cellArray[indexPath.row][@"info"][@"nickname"];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:self.cellArray[indexPath.row][@"info"][@"avatar"]] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            cell.avatar.image = image;
        }];
        cell.lastSentence.text = self.cellArray[indexPath.row][@"message"];
        cell.lastTime.text = self.cellArray[indexPath.row][@"time"];
        if ([self.cellArray[indexPath.row][@"num"] isEqualToString:@"0"]) {
            cell.messageCount.hidden = YES;
        }else{
            cell.messageCount.hidden = NO;
            cell.messageCount.text = self.cellArray[indexPath.row][@"num"];
        }
        return cell;
    }else{
        ZZXPhoneListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phone" forIndexPath:indexPath];
        cell.nickName.text = [NSString stringWithFormat:@"朋友%ld",indexPath.row];
        cell.avatar.image = [UIImage imageNamed:@"friend"];
        NSArray *array = @[@"视频",@"电话"];
        cell.netStatus.text = array[arc4random() % 2];
        cell.status.text = @"星期日";
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.seletedIndex == 0) {
        ZZXMessageListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.messageCount.hidden = YES;
        NSUInteger cellMessageCount = [self.cellArray[indexPath.row][@"num"] integerValue];
        self.messageCount = self.messageCount - cellMessageCount;
        NSMutableArray *mutabl = [[TMCache sharedCache] objectForKey:kUserDefaultMessageList];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:mutabl[indexPath.row]];
        NSString *str = @"0";
        [dic setObject:str forKey:@"num"];
        [mutabl replaceObjectAtIndex:indexPath.row withObject:dic];
        self.cellArray = mutabl;
        [[TMCache sharedCache]setObject:self.cellArray forKey:kUserDefaultMessageList];
        NSArray *array = [[TMCache sharedCache]objectForKey:self.cellArray[indexPath.row][@"info"][@"id"]];
        ZZXChatRoomViewController *vc = [[ZZXChatRoomViewController alloc]init];
        vc.totalChatArray = array;
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
