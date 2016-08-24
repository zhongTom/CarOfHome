//
//  InfoLisViewModel.h
//  TRProject
//
//  Created by 钟至大 on 16/7/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoListNetManager.h"
#import "NSObject+ViewModel.h"


@interface InfoLisViewModel : NSObject
/** 获取滚动栏中的详情标题 */
- (NSString *)topDetailTitleForRow:(NSInteger)row;
/** 获取滚动栏中的详情地址 */
- (NSURL*)topDetailURLForRow:(NSInteger)row;
/** 获取详情页标题 */
- (NSString *)detailTitleForRow:(NSInteger)row;
/** 获取详情页链接地址 */
- (NSURL *)detailURLForRow:(NSInteger)row;
/** 根据效果图来决定属性和方法 */
@property (nonatomic) NSInteger rowNumber;
/** 返回当前页是否有头部滚动栏 */
@property (nonatomic,getter=isHasTopView) BOOL hasTopView;
/** 返回头部滚动栏的个数 */
@property (nonatomic) NSInteger topNumber;
/** 每个显示什么内容 */
- (NSURL *)topIconURLForIndex:(NSInteger)index;
/** 保存头部滚动栏数据的数组 */
@property (nonatomic) NSArray *topList;
- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)dateForRow:(NSInteger)row;
- (NSString *)commentNumForRow:(NSInteger)row;
- (InfoListNewslistModel *)modelForRow:(NSInteger)row;

/** 根据接口来决定属性和方法 */
@property (nonatomic) NSInteger page;
@property (nonatomic) NSString *lastTime;
@property (nonatomic) InfoListType infoListType;
- (instancetype)initWithInfoListType:(InfoListType)infoListType;


@property (nonatomic) NSMutableArray<InfoListNewslistModel *> *dataList;
@end
