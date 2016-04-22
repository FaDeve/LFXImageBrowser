//
//  LWImageBrowserCell.h
//  LWAsyncLayerDemo
//
//  Created by 刘微 on 16/2/19.
//  Copyright © 2016年 Warm+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWImageBrowserModel.h"
#import "LWImageItem.h"


@interface LWImageBrowserCell : UICollectionViewCell

@property (nonatomic,strong) LWImageBrowserModel* imageModel;
@property (nonatomic,strong) LWImageItem* imageItem;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com