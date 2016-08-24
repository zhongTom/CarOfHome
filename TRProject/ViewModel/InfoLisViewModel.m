//
//  InfoLisViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/7/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "InfoLisViewModel.h"

#define kDetailPath @"http://cont.app.autohome.com.cn/autov5.0.0/content/news/newscontent-n%ld-t0-rct1.json"
#warning 必须在.m中引入，在.h中会出现循环引用头文件问题，会爆红
#import "CacheManager.h"
@implementation InfoLisViewModel
- (NSString *)topDetailTitleForRow:(NSInteger)row{
    InfoListFocusimgModel *model = self.topList[row];
    return model.title;
}
- (NSURL *)topDetailURLForRow:(NSInteger)row{
    InfoListFocusimgModel *model = self.topList[row];
    NSString *path = [NSString stringWithFormat:kDetailPath,model.ID];
    return [NSURL URLWithString:path];
}
- (NSString *)detailTitleForRow:(NSInteger)row{

    return [self modelForRow:row].title;
}
- (NSURL *)detailURLForRow:(NSInteger)row{
    NSInteger ID = [self modelForRow:row].ID;
    NSString *path = [NSString stringWithFormat:kDetailPath,ID];
    return [NSURL URLWithString:path];
}
//MJExtension框架提供的归档宏
MJCodingImplementation
- (instancetype)initWithInfoListType:(InfoListType)infoListType{
    if (self = [super init]) {
        self.infoListType = infoListType;
        id obj = [CacheManager getInfoListVMWithType:infoListType];
        if (obj) {
            self = obj;
        }
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        //断言，会让项目崩溃
        NSAssert(NO, @"%s必须使用initWithInfoListType:(InfoListType)infoListType方法初始化",__func__);
    }
    return nil;
}
- (NSInteger)rowNumber{
    return self.dataList.count;
}
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}
- (NSURL *)iconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].smallpic];
}
- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSString *)dateForRow:(NSInteger)row{
    return [self modelForRow:row].time;
}
- (NSString *)commentNumForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"%ld评论",[self modelForRow:row].replycount];
}
- (InfoListNewslistModel *)modelForRow:(NSInteger)row{
    return self.dataList[row];
}
- (NSString *)lastTime{
    return self.dataList.lastObject.lasttime;
}
- (void)getDataWithRequestMode:(RequestMode)requestMode completionHandle:(void (^)(NSError *))completionHandle{
    NSInteger tmpPage = 0;
    NSString *tmpLastTime = nil;
    switch (requestMode) {
        case RequestModeRefresh: {
            tmpPage = 1;
            tmpLastTime = @"0";
            break;
        }
        case RequestModeMore: {
            tmpPage = _page +1;
            tmpLastTime = self.lastTime;
            break;
        }
    }
    self.dataTask = [InfoListNetManager getInfoListWithType:self.infoListType updateTime:tmpLastTime page:tmpPage completionHandle:^(InfoListModel *model, NSError *error) {
        if (!error) {
            //是刷新的话,清空数组
            if (requestMode == RequestModeRefresh) {
                [self.dataList removeAllObjects];
                //focusimg中就是滚动广告栏的数据
                self.topList = model.result.focusimg;
            }
            [self.dataList addObjectsFromArray:model.result.ewslist];
            _page = tmpPage;
            
            if (tmpPage == 1) {
                NSLog(@"%ld",tmpPage);
                [CacheManager saveInfoListVM:self];
            }
            
            
        }
        completionHandle(error);
    }];
}
- (BOOL)isHasTopView{
    return self.topList.count != 0;
}
- (NSInteger)topNumber{
    return self.topList.count;
}
- (NSURL *)topIconURLForIndex:(NSInteger)index{
    InfoListFocusimgModel *model = self.topList[index];
    NSURL *url = [NSURL URLWithString:model.imgurl];
    return url;
}
@end
