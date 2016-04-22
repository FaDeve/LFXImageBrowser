//
//  LFXImageItem.h
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageModel;


@protocol LFXImageItemDelegate <NSObject>

@optional

- (void)didClickedItemToHide;

@end

@interface LFXImageItem : UIScrollView

/*  一般的情况是传一个数据模型过来，里面包含了图片的信息*/

@property (nonatomic,strong) ImageModel * imageModel;

/**
 *  是否第一次显示
 */
@property (nonatomic,assign,getter=isFirstShow) BOOL firstShow;



/**
 *  加载显示图片的UIImageView
 */
@property (strong, nonatomic) UIImageView *imageView;

/**
 *  代理
 */
@property (weak, nonatomic) id <LFXImageItemDelegate> ImageItemDelegate;
@end
