//
//  InfoListModel.h
//  TRProject
//
//  Created by tarena on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InfoListResultModel,InfoListHeadlineinfoModel,InfoListTopnewsinfoModel,InfoListNewslistModel,InfoListFocusimgModel;
@interface InfoListModel : NSObject
@property (nonatomic, strong) InfoListResultModel *result;
@property (nonatomic, assign) NSInteger returncode;
@property (nonatomic, copy) NSString *message;
@end

@interface InfoListResultModel : NSObject

@property (nonatomic, assign) BOOL isloadmore;
@property (nonatomic, assign) NSInteger rowcount;
@property (nonatomic, strong) InfoListHeadlineinfoModel *headlineinfo;
@property (nonatomic, strong) NSArray<InfoListFocusimgModel *> *focusimg;
#warning new是系统关键词, 不能作为变量命名开头
//newslist - > ewslist
@property (nonatomic, strong) NSArray<InfoListNewslistModel *> *ewslist;
@property (nonatomic, strong) InfoListTopnewsinfoModel *topnewsinfo;

@end

@interface InfoListHeadlineinfoModel : NSObject
// id -> ID
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *smallpic;
@property (nonatomic, assign) NSInteger replycount;
@property (nonatomic, copy) NSString *lasttime;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger mediatype;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, assign) NSInteger jumppage;
@property (nonatomic, copy) NSString *indexdetail;
@property (nonatomic, assign) NSInteger pagecount;
@property (nonatomic, strong) NSArray *coverimages;

@end

@interface InfoListTopnewsinfoModel : NSObject

@end

@interface InfoListNewslistModel : InfoListHeadlineinfoModel
//newstype -> ewstype
@property (nonatomic, assign) NSInteger ewstype;

@end

@interface InfoListFocusimgModel : NSObject

@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *jumpurl;
@property (nonatomic, copy) NSString *updatetime;
//id -> ID
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger replycount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger pageindex;
@property (nonatomic, assign) NSInteger JumpType;
@property (nonatomic, assign) NSInteger mediatype;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger fromtype;

@end

