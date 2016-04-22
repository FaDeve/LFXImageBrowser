//
//  CellLayout.h
//  LWAsyncDisplayViewDemo
//
//  Created by 刘微 on 16/3/16.
//  Copyright © 2016年 WayneInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWTextLayout.h"
#import "LWTextParser.h"
#import "CDStatus.h"


@interface CellLayout : NSObject

@property (nonatomic,strong) CDStatus* statusModel;
@property (nonatomic,strong) LWTextLayout* nameTextLayout;
@property (nonatomic,strong) LWTextLayout* contentTextLayout;
@property (nonatomic,strong) LWTextLayout* dateTextLayout;

@property (nonatomic,assign) CGRect avatarPosition;
@property (nonatomic,assign) CGRect menuPosition;
@property (nonatomic,assign) CGRect likesAndCommentsPosition;
@property (nonatomic,copy) NSArray* imagePostionArray;

@property (nonatomic,assign) CGFloat textHeight;
@property (nonatomic,assign) CGFloat imagesHeight;
@property (nonatomic,assign) CGFloat likesAndCommentsHeight;
@property (nonatomic,assign) CGRect commentBgPosition;
@property (nonatomic,copy) NSArray* commentTextLayouts;
@property (nonatomic,assign) CGFloat cellHeight;

- (id)initWithCDStatusModel:(CDStatus *)statusModel;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com