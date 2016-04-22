//
//  LFXImageBrowserViewController.h
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFXImageItem;



/**
*  图片浏览器式样
*/
typedef NS_ENUM(NSUInteger, LFXImageBrowserShowAnimationStyle){
    LWImageBrowserAnimationStyleScale,
    LWImageBrowserAnimationStylePush,
};


@interface LFXImageBrowserViewController : UIViewController


/**
 *  存放图片模型的数组
 */
@property (nonatomic,copy)NSArray* imageModels;

/**
 *  当前页码
 */
@property (nonatomic,assign) NSInteger currentIndex;


/**
 *  浏览器式样
 */
@property (nonatomic,assign) LFXImageBrowserShowAnimationStyle style;

/**
 *  当前的ImageItem
 */
@property (nonatomic,strong) LFXImageItem* currentImageItem;


/**
 *  创建并初始化一个LWImageBrowser
 *
 *  @param parentVC    父级ViewController
 *  @param style       图片浏览器式样
 *  @param imageModels 一个存放LWImageModel的数组
 *  @param index       初始化的图片的Index
 *
 */
- (id)initWithParentViewController:(UIViewController *)parentVC
                             style:(LFXImageBrowserShowAnimationStyle)style
                       imageModels:(NSArray *)imageModels
                      currentIndex:(NSInteger)index;

/**
 *  显示图片浏览器
 */
- (void)show;


@end
