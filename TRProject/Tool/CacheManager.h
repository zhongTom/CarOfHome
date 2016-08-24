//
//  CacheManager.h
//  TRProject
//
//  Created by 钟至大 on 16/7/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoLisViewModel.h"
@interface CacheManager : NSObject
/** 归档，压缩 */
+ (BOOL)saveInfoListVM:(InfoLisViewModel *)infoListVM;
/** 解档，解压缩 */
+ (id)getInfoListVMWithType:(InfoListType)infoListType;
/** 获取路径 */
+ (NSString *)pathForInfoListType:(InfoListType)infoListType;
@end
