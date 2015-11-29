//
//  SLQScrollView.m
//  SLQScrollView
//
//  Created by songlq on 15/10/27.
//  Copyright (c) 2015年 songlq. All rights reserved.
//
#import "SLQScrollView.h"

@interface SLQScrollView()

@property (nonatomic,strong) CADisplayLink *scrollTimer1;
@property (nonatomic,strong) CADisplayLink *scrollTimer2;

/**索引1*/
@property (nonatomic, assign) NSInteger index;
/**索引2*/
@property (nonatomic, assign) NSInteger next;

@end

@implementation SLQScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)reloadDataWithArray:(NSArray *)titleArray
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeAllTimers];
    [self setupScrollViewWithArray:titleArray];
}

/**
 *  初始化scrollView
 */
- (void)setupScrollViewWithArray:(NSArray *)titleArray
{
    self.index = 0;
    self.next = 0;
    
    for(NSInteger i = 0 ; i < titleArray.count ; i++)
    {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        
        view.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        label.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        label.text =  titleArray[i];
        label.center = CGPointMake(0, view.center.y / 2);
        [label sizeToFit];
        label.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        label.tag = LABELTAG + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        view.clipsToBounds = YES;
        [self addSubview:view];
        self.clipsToBounds = YES;
    }
    
    self.scrollTimer1 = [CADisplayLink displayLinkWithTarget:self selector:@selector(scrollView1)];
    [self.scrollTimer1 addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    self.scrollTimer2 = [CADisplayLink displayLinkWithTarget:self selector:@selector(scrollView2)];
    [self.scrollTimer2 addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.scrollTimer2.paused = YES;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    [self setupScrollViewWithArray:titleArray];
}

-(void)tapClick:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(scrollView:didClickItemWithIndex:)]) {
        [self.delegate scrollView:self didClickItemWithIndex:tap.view.tag - LABELTAG + 1];
    }
}

/// 定时器1
- (void)scrollView1
{
    NSInteger count = self.subviews.count;
    if (count == 0) {
        return;
    }
    UIView *view = self.subviews[self.index]; // 取出View
    CGRect rect = view.frame;
    rect.origin.x -- ;
    view.frame = rect;
    
    // 距离屏幕右侧100时开启下一个定时器
    if ((view.frame.origin.x <= - view.frame.size.width + self.frame.size.width - self.margin) &&
        (view.frame.origin.x >= - view.frame.size.width + self.frame.size.width - self.margin - 3)) {
        // 只有一个广播就不开启下一个定时器
        if (count == 1) {
            self.scrollTimer2.paused = YES;
        }else {
            self.scrollTimer2.paused = NO;
            _next = (_index + 1)%count;
        }
    }
    // 开启下一个定时器并恢复自身位置
    else if (view.frame.origin.x <= -(view.frame.size.width) &&
             view.frame.origin.x >= -(view.frame.size.width + 3)) {
        
        rect.origin.x  = self.frame.size.width;
        view.frame = rect;
        if (count == 1) {
            self.scrollTimer1.paused = NO;
        }else {
            self.scrollTimer1.paused = YES;
        }
        
    }
}

/// 定时器2
- (void)scrollView2
{
    NSInteger count = self.subviews.count;
    if (count == 0) {
        return;
    }
    UIView *view = self.subviews[self.next]; // 取出View
    CGRect rect = view.frame;
    rect.origin.x -- ;
    view.frame = rect;
    
    // 距离屏幕右侧100时开启下一个定时器
    if ((view.frame.origin.x <= - view.frame.size.width + self.frame.size.width - self.margin) &&
        (view.frame.origin.x >= - view.frame.size.width + self.frame.size.width - self.margin - 3)) {
        // 只有一个广播就不开启下一个定时器
        if (count == 1) {
            self.scrollTimer1.paused = YES;
        }else {
            self.scrollTimer1.paused = NO;
            _index = (_next + 1)%count;
        }
    }
    else if (view.frame.origin.x <= -(view.frame.size.width) &&
             view.frame.origin.x >= -(view.frame.size.width + 3)) {
        // 开启下一个定时器并恢复自身位置
        rect.origin.x  = self.frame.size.width ;
        view.frame = rect;
        if (count == 1) {
            self.scrollTimer2.paused = NO;
        }else {
            self.scrollTimer2.paused = YES;
        }
    }
}

- (void)removeAllTimers
{
    [self.scrollTimer1 invalidate];
    [self.scrollTimer2 invalidate];
    self.scrollTimer2 = nil;
    self.scrollTimer1 = nil;
}
- (void)dealloc
{
    [self removeAllTimers];
}

@end
