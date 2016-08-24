//
//  CacheManager.m
//  TRProject
//
//  Created by 钟至大 on 16/7/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager
+ (NSString *)pathForInfoListType:(InfoListType)infoListType{
    return [kDocPath stringByAppendingPathComponent:@(infoListType).stringValue];
}
+ (BOOL)saveInfoListVM:(InfoLisViewModel *)infoListVM{ 
    NSString *path = [self pathForInfoListType:infoListVM.infoListType];
    NSLog(@"%ld",infoListVM.dataList.count);
    return [NSKeyedArchiver archiveRootObject:infoListVM toFile:path];
}
+ (id)getInfoListVMWithType:(InfoListType)infoListType{
    InfoLisViewModel *listVM = [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathForInfoListType:infoListType]];
    
    NSLog(@"%ld",listVM.dataList.count);
   
    return listVM;
}
@end
