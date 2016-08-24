//
//  InfoListNetManager.m
//  TRProject
//
//  Created by tarena on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "InfoListNetManager.h"
#import "InfoListPath.h"

@implementation InfoListNetManager

+ (id)getInfoListWithType:(InfoListType)listType updateTime:(NSString *)updateTime page:(NSInteger)page completionHandle:(void (^)(id, NSError *))completionHandle{
    NSString *path = nil;
    switch (listType) {
        case InfoListTypeZuiXin: {
            path = [NSString stringWithFormat:kZuiXinPath, updateTime];
            break;
        }
        case InfoListTypeXinWen: {
            path = [NSString stringWithFormat:kXinWenPath, page, updateTime];
            break;
        }
        case InfoListTypePingCe: {
            path = [NSString stringWithFormat:kPingCePath, page, updateTime];
            break;
        }
        case InfoListTypeDaoGou: {
            path = [NSString stringWithFormat:kDaoGouPath, page, updateTime];
            break;
        }
        case InfoListTypeHangQing: {
            path = [NSString stringWithFormat:kHangQingPath, page];
            break;
        }
        case InfoListTypeYongChe: {
            path = [NSString stringWithFormat:kYongChePath, page, updateTime];
            break;
        }
        case InfoListTypeJiShu: {
            path = [NSString stringWithFormat:kJiShuPath, page, updateTime];
            break;
        }
        case InfoListTypeWenHua: {
            path = [NSString stringWithFormat:kWenHuaPath, page, updateTime];
            break;
        }
        case InfoListTypeGaiZhuang: {
            path = [NSString stringWithFormat:kGaiZhuangPath, page, updateTime];
            break;
        }
        case InfoListTypeYouJi: {
            path = [NSString stringWithFormat:kYouJiPath, page, updateTime];
            break;
        }
    }
    return [self GET:path parameters:nil progress:nil completionHandle:^(id responseObj, NSError *error) {
        completionHandle([InfoListModel parse:responseObj], error);
    }];
    
}

@end













