//
//  PageViewController.m
//  TRProject
//
//  Created by 钟至大 on 16/7/30.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PageViewController.h"
#import "ViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //显示在导航栏上
        self.showOnNavigationBar = YES;
        //设置高度
        self.menuHeight = 40;
        //设置每个题目的宽度
//        self.menuItemWidth = 40;
        //设置菜单的背景色
//        self.menuBGColor = [UIColor purpleColor];
        //设置字体颜色
//        self.titleColorNormal = [UIColor redColor];
        //带有下划线风格
        self.menuViewStyle = WMMenuViewStyleLine;
        //标题大小
//        self.titleSizeNormal = 20;
    }
    return self;
}
//重写父类的titless属性的getter方法，设置题目
- (NSArray *)titles{
    return @[@"最新",@"新闻",@"测评",@"导购",@"行情",@"用车",@"技术",@"文化",@"改装",@"游记"];
}
#pragma mark - PageViewController Delegate
//1.内部有多少个子控制器
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}
//2.每个子控制器是什么样
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    vc.listType = index;
    return vc;
}
//3.每个控制器的题目是什么
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
#pragma mark - 生命周期 Life Circle


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
