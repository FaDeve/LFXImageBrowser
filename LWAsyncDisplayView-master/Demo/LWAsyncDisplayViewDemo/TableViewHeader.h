//
//  TableViewHeader.h
//  LWAsyncDisplayViewDemo
//
//  Created by 刘微 on 16/3/16.
//  Copyright © 2016年 WayneInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewHeader : UIView

- (void)loadingViewAnimateWithScrollViewContentOffset:(CGFloat)offset;
- (void)refreshingAnimateBegin;
- (void)refreshingAnimateStop;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com