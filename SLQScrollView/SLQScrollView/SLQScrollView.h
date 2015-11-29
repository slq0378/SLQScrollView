//
//  SLQScrollView.h
//  SLQScrollView
//
//  Created by songlq on 15/10/27.
//  Copyright (c) 2015年 songlq. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LABELTAG 200


@class SLQScrollView;

@protocol SLQScrollViewDelegate <NSObject>

@optional
- (void)scrollView:(SLQScrollView *)scrollView didClickItemWithIndex:(NSInteger )index;
@end

@interface SLQScrollView : UIView

/// 代理
@property (nonatomic, weak) id<SLQScrollViewDelegate> delegate;
/**间隔*/
@property (nonatomic, assign) NSInteger margin;
/// title数组
@property (nonatomic, copy) NSArray *titleArray;
/// 移除定时器
- (void)removeAllTimers;
/// 更新加载数据
- (void)reloadDataWithArray:(NSArray *)titleArray;

@end
