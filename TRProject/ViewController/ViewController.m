//
//  ViewController.m
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "InfoLisViewModel.h"
#import "UIScrollView+Refresh.h"
#import "InfoListCell.h"
#import "iCarousel.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) InfoLisViewModel *infoListVM;
@property (nonatomic) iCarousel *ic;
//页数展示
@property (nonatomic) UIPageControl *pc;
@end

@implementation ViewController
//当左右滑动切换控制器时，停止当前界面的网络活动
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.infoListVM suspendTask];
}
//界面重新显示时，恢复网络活动
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.infoListVM resumeTask];
}

#pragma mark - iCarousel Delegate

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.infoListVM.topNumber;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIImageView alloc]initWithFrame:carousel.frame];
        UIImageView *iconIV = [UIImageView new];
        [view addSubview:iconIV];
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        iconIV.tag = 100;
    }
    UIImageView *iconIV = [view viewWithTag:100];
    
    NSLog(@"%@",[self.infoListVM topIconURLForIndex:index]);
    NSURL *url  = [self.infoListVM topIconURLForIndex:index];
    if (url) {
         [iconIV setImageWithURL:url];
    }
   
    return view;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}
//当ic中的页面发生变化时触发
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pc.currentPage = carousel.currentItemIndex;
}
//ic被选中时触发
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    DetailViewController *vc = [[DetailViewController alloc]initWithURL:[self.infoListVM topDetailURLForRow:index] title:[self.infoListVM topDetailTitleForRow:index]];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoListVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.iconIV setImageWithURL:[self.infoListVM iconURLForRow:indexPath.row]];
    cell.titleLb.text = [self.infoListVM titleForRow:indexPath.row];
    cell.dateLb.text = [self.infoListVM dateForRow:indexPath.row];
    cell.commentLb.text = [self.infoListVM commentNumForRow:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[DetailViewController alloc]initWithURL:[self.infoListVM detailURLForRow:indexPath.row] title:[self.infoListVM detailTitleForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 生命周期 Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:@"InfoListCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [_tableView addHeaderRefresh:^{
        [self.infoListVM getDataWithRequestMode:RequestModeRefresh completionHandle:^(NSError *error) {
            if (!error) {
                if (self.infoListVM.isHasTopView) {
                    _tableView.tableHeaderView = self.ic;
                    _pc.numberOfPages = self.infoListVM.topNumber;
                }else{
                    _tableView.tableHeaderView = nil;
                }
                [_tableView reloadData];
            }
            [_tableView endHeaderRefresh];
        }];
    }];
    [_tableView addAutoFooterRefresh:^{
        [self.infoListVM getDataWithRequestMode:RequestModeMore completionHandle:^(NSError *error) {
            if (!error) {
                [_tableView reloadData];
            }
            [_tableView endFooterRefresh];
        }];
    }];
    [self.tableView beginHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 懒加载 Lazy Load


- (InfoLisViewModel *)infoListVM {
    if(_infoListVM == nil) {
        _infoListVM = [[InfoLisViewModel alloc] initWithInfoListType:self.listType];
    }
    return _infoListVM;
}

- (iCarousel *)ic {
	if(_ic == nil) {
        //ic是防在tableView的header上，xy无效
		_ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*370/750)];
        _ic.delegate = self;
        _ic.dataSource = self;
        _ic.scrollSpeed = 0.1;
        _ic.type = iCarouselTypeLinear;
        _pc = [UIPageControl new];
        [_ic addSubview:_pc];
        [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(10);
        }];
        _pc.userInteractionEnabled = NO;
        //添加定时器,自动滚动
        //[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
//        BlocksKit->把系统类的Target+Selector方式进行回调，改为block方式，特点是方法名以bk_开头
        [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
            [_ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
        } repeats:YES];
	}
	return _ic;
}
- (void)autoScroll{
    [_ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
}
@end
