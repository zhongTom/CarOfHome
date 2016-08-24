//
//  Factory.h
//  TRProject
//
//  Created by jiyingxin on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject
/** 向控制器上拼接返回按钮 */
+ (void)addBackItemToVC:(UIViewController *)vc;
+ (NSString *)md5:(NSString *)str;
@end
