//
//  NSObject+AFNetworking.m
//  Day08_Beauty
//
//  Created by tarena on 16/2/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NSObject+AFNetworking.h"

#import <MBProgressHUD.h>
@implementation NSObject (AFNetworking)
+ (id)GET:(NSString *)path parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandle:(void (^)(id, NSError *))completionHandle{
//    //判断当前网络状态
//    if(kAppdelegate.isOnLine == NO){
//        //在window上弹出提示，告知用户无网络
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kAppdelegate.window animated:YES];
//        //纯文本模式
//        hud.mode = MBProgressHUDModeIndeterminate;
//        //设置文字
//        hud.labelText = @"无网络，请稍后再试";
//        //设置弹出时间
//        [hud hide:YES afterDelay:1];
//        //参数2相当于错误代码
//        //userInfo中的key值，会自动存入error的localizedDescription属性中
//        NSError *error = [NSError errorWithDomain:path code:1234 userInfo:@{NSLocalizedDescriptionKey:@"无网络"}];
//        completionHandle(nil,error);
//        return nil;
//    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = 30;
    return [manager GET:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil, error);
        NSLog(@"error %@", error);
    }];
}

+ (id)POST:(NSString *)path parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandle:(void (^)(id, NSError *))completionHandle{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = 30;
    return [manager POST:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil, error);
        NSLog(@"error %@", error);
    }];
}

@end
