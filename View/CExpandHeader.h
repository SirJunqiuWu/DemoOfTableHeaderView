//
//  InfoHeaderView.h
//  DemoOfTableHeaderView
//
//  Created by 吴 吴 on 16/9/12.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CExpandHeader : NSObject <UIScrollViewDelegate>

#pragma mark - 类方法 
/**
 *  生成一个CExpandHeader实例
 *
 *  @param scrollView 当前滑动对象(UIScrollView或者其子类)
 *  @param expandView 可以伸展的背景View
 *
 *  @return CExpandHeader 本身
 */
+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;


#pragma mark - 成员方法
/**
 *  对外方法
 *
 *  @param scrollView
 *  @param expandView
 */
- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;

/**
 *  监听scrollViewDidScroll方法
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

@end

