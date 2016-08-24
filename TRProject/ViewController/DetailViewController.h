//
//  DetailViewController.h
//  TRProject
//
//  Created by 钟至大 on 16/8/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic) UIWebView *webView;
@property (nonatomic,readonly) NSURL *webURL;
//接收外部传参，是网页地址
- (instancetype)initWithURL:(NSURL *)webURL title:(NSString *)title;

@property (nonatomic) NSString *title;
@end
