//
//  AppDelegate.m
//  ZZXQQList
//
//  Created by 邹圳巡 on 16/4/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZXDynamicController.h"
#import "ZZXFriendListController.h"
#import "ZZXMessageListController.h"
#import "ZZXBaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tabbar = [[UITabBarController alloc]init];
    self.window.rootViewController = tabbar;
    
    ZZXMessageListController *message = [[ZZXMessageListController alloc]init];
    ZZXBaseNavigationController *messageNav = [[ZZXBaseNavigationController alloc]initWithRootViewController:message];
    message.tabBarItem.title = @"消息";
    message.tabBarItem.image = [UIImage imageNamed:@"message"];
    
    ZZXFriendListController *friend = [[ZZXFriendListController alloc]init];
    ZZXBaseNavigationController *friendNav = [[ZZXBaseNavigationController alloc]initWithRootViewController:friend];
    friend.tabBarItem.title = @"联系人";
    friend.tabBarItem.image = [UIImage imageNamed:@"friend"];
    
    ZZXDynamicController *dynamic = [[ZZXDynamicController alloc]init];
    ZZXBaseNavigationController *dynamicNav = [[ZZXBaseNavigationController alloc]initWithRootViewController:dynamic];
    dynamic.tabBarItem.title = @"动态";
    dynamic.tabBarItem.image = [UIImage imageNamed:@"dynamic"];
    
    tabbar.viewControllers = @[messageNav,friendNav,dynamicNav];
    tabbar.selectedIndex = 1;
    [self.window makeKeyAndVisible];
    
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(pushNotification) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return YES;
}

- (void)pushNotification{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UILocalNotification*notification = [[UILocalNotification alloc]init];
        NSDate * pushDate = [NSDate dateWithTimeIntervalSinceNow:5];
        if (notification != nil) {
            notification.fireDate = pushDate;
            notification.timeZone = [NSTimeZone defaultTimeZone];
            notification.repeatInterval = kCFCalendarUnitDay;
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.alertBody = @"收到一条消息";
            notification.applicationIconBadgeNumber = 0;
            NSArray *array = @[@"你好啊",@"你在哪里",@"我知道了"];
            NSDate *  senddate=[NSDate date];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"HH:mm"];
            NSString *  locationString=[dateformatter stringFromDate:senddate];
            NSDictionary *dic = [NSDictionary dictionary];
            dic = @{
                    @"message" : array[arc4random()%3],
                    @"time": locationString,
                    @"num":@"1"
                    };
            NSDictionary*info = dic;
            notification.userInfo = info;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    });
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSNotification * notice =[NSNotification notificationWithName:kNotificationName object:nil userInfo:notification.userInfo];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
