//
//  InfoHeaderView.h
//  DemoOfTableHeaderView
//
//  Created by 吴 吴 on 16/9/12.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#define CExpandContentOffset @"contentOffset"

#import "CExpandHeader.h"

@implementation CExpandHeader
{
    /**
     *  scrollView或者其子类
     */
    __weak UIScrollView *_scrollView;
    /**
     *  背景可以伸展的View
     */
    __weak UIView       *_expandView;
    /**
     *  可变视图的原始高度
     */
    CGFloat             _expandHeight;
}



+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView {
    CExpandHeader *expandHeader = [CExpandHeader new];
    [expandHeader expandWithScrollView:scrollView expandView:expandView];
    return expandHeader;
}

- (void)expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView {
    /**
     * 变量初始化
     */
    _expandHeight = CGRectGetHeight(expandView.frame);
    _scrollView   = scrollView;
    _expandView   = expandView;

    /**
     *  关键处:将可扩展视图作为滑动视图的第一层视图
     */
    [_scrollView insertSubview:expandView atIndex:0];
    [_scrollView addObserver:self forKeyPath:CExpandContentOffset options:NSKeyValueObservingOptionNew context:nil];

    /**
     *  使View可以伸展效果(重要属性,在改变视图高度过程中,图片对应延伸)
     */
    _expandView.contentMode   = UIViewContentModeScaleAspectFill;
    _expandView.clipsToBounds = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (![keyPath isEqualToString:CExpandContentOffset])
    {
        return;
    }
    [self scrollViewDidScroll:_scrollView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY <= 0)
    {
        /**
         *  改变可变视图的高度
         */
        CGRect currentFrame = _expandView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1 * offsetY + _expandHeight;
        _expandView.frame = currentFrame;
    }
}

- (void)dealloc {
    if (_scrollView)
    {
        [_scrollView removeObserver:self forKeyPath:CExpandContentOffset];
        _scrollView = nil;
    }
    _expandView = nil;
}

@end
