//
//  InfoListNetManager.h
//  TRProject
//
//  Created by tarena on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+AFNetworking.h"
#import "InfoListModel.h"

typedef NS_ENUM(NSUInteger, InfoListType) {
    InfoListTypeZuiXin,
    InfoListTypeXinWen,
    InfoListTypePingCe,
    InfoListTypeDaoGou,
    InfoListTypeHangQing,
    InfoListTypeYongChe,
    InfoListTypeJiShu,
    InfoListTypeWenHua,
    InfoListTypeGaiZhuang,
    InfoListTypeYouJi,
};

@interface InfoListNetManager : NSObject
/**
 *  获取新闻列表
 *
 *  @param listType   新闻的类别
 *  @param updateTime 当前最后一条信息的更新时间
 *  @param page       页数, 从1开始
 *
 *  @return 执行请求的任务
 */
+ (id)getInfoListWithType:(InfoListType)listType updateTime:(NSString *)updateTime page:(NSInteger)page completionHandle:(void (^)(id model, NSError *error))completionHandle;

@end










