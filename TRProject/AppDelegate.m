//
//  AppDelegate.m
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

/**
 友盟统计的集成
 1.参考官方文档，按照流程一步一步做
 3。流程：注册新应用->拿到key->引入sdk->通过代码启动
 */
#import "AppDelegate.h"
#import "AppDelegate+System.h"
#import "MobClick.h"
#import <MLTransition.h>
#define kUMengKey @"579c7e7967e58e8af4002f10"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //解决自定义左上角按钮导致的右滑手势返回无效
    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    //启动友盟统计功能 参数3传nil代表是从APPStore下载的
    [MobClick startWithAppkey:kUMengKey reportPolicy:BATCH channelId:nil];
    //全局默认配置
    [self setupGlobalConfig];
    return YES;
}

@end
