//
//  InfoListModel.m
//  TRProject
//
//  Created by tarena on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "InfoListModel.h"

@implementation InfoListModel
MJCodingImplementation
@end

@implementation InfoListResultModel
MJCodingImplementation
+ (NSDictionary *)objClassInArray{
    return @{@"ewslist" : [InfoListNewslistModel class], @"focusimg" : [InfoListFocusimgModel class]};
}

+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ewslist": @"newslist"};
}
@end
@implementation InfoListHeadlineinfoModel
MJCodingImplementation
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID": @"id"};
}
@end

@implementation InfoListTopnewsinfoModel
MJCodingImplementation
@end

@implementation InfoListNewslistModel
MJCodingImplementation
+ (NSDictionary *)replaceKeyFromPropertyName{
    NSMutableDictionary *dic = [[super replaceKeyFromPropertyName] mutableCopy];
    [dic setObject:@"newstype" forKey:@"ewstype"];
    return dic;
}
@end

@implementation InfoListFocusimgModel
MJCodingImplementation
+ (NSDictionary *)replaceKeyFromPropertyName{
    return @{@"ID": @"id"};
}

@end





