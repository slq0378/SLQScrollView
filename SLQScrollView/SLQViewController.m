//
//  SLQViewController.m
//  SLQScrollView
//
//  Created by songlq on 15/10/27.
//  Copyright (c) 2015年 songlq. All rights reserved.
//  滚动条

#define LABELTAG 200
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "SLQViewController.h"
#import "SLQScrollView.h"


@interface SLQViewController () <SLQScrollViewDelegate>
/**滚动条*/
@property (nonatomic, weak) SLQScrollView *scrollView;
@end

@implementation SLQViewController

- (void)dealloc
{
    [self.scrollView removeAllTimers];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(40, 250, 44, 20);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"更新数据" forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    SLQScrollView *scrollView = [[SLQScrollView alloc] initWithFrame:CGRectMake(0, 100, 200, 44)];
    scrollView.delegate = self;
    scrollView.margin = 10;
    scrollView.titleArray = @[@"哈哈哈哈哈哈哈啊哈哈",
                              @"laladhfakjdhfn啊到时罚款交话费的凯撒减肥哈达可使肌肤哈萨克",
                              @"hahhahakdhfkdajfhadskjfhasuhraeiowhroiwehroijewoi"];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)scrollView:(SLQScrollView *)scrollView didClickItemWithIndex:(NSInteger)index
{
    NSLog(@"i am the %zd item",index);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"俺是控件%zd",index] message:@"哈哈哈" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)updateData
{
    [self.scrollView  reloadDataWithArray:@[@"11111111111111",@"22222222222222",@"33333333333333",@"4444444444444444"]];
}
@end