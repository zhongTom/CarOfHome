//
//  DetailViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/1.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        self.navigationItem.title = @"第二页";
//    }
//    return self;
//}
#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error:%@",error);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark - 懒加载 Lazy Load


- (UIWebView *)webView{
    if (!_webView) {
        _webView= [UIWebView new];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _webView;
}
- (instancetype)initWithURL:(NSURL *)webURL title:(NSString *)title{
    if (self = [super init]) {
        _webURL = webURL;//只读不能用self
        self.title = title;
    }
    return self;
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad{
    [Factory addBackItemToVC:self];
    self.navigationItem.title = self.title;
    //判断网络状态
    if (!kAppdelegate.isOnLine) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"无网络，稍后再试";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webURL]];
}
@end
