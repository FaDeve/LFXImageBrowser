//
//  ImageModel.h
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageModel : NSObject

@property (copy, nonatomic) NSString *imageName;

/**
 *  是否已经下载
 */
@property (nonatomic,assign,readonly) BOOL isDownload;

/**
 *  原始位置（在window坐标系中）
 */
@property (nonatomic,assign) CGRect originPosition;

/**
 *  计算后的位置
 */
@property (nonatomic,assign,readonly) CGRect destinationFrame;

/**
 *  标号
 */
@property (nonatomic,assign) NSInteger index;

/**
 标题
 */
@property (nonatomic,copy) NSString* title;

/**
 *  详细描述
 */
@property (nonatomic,copy) NSString* contentDescription;






/**
 *  创建ImageModel实例对象
 *
 *  @param imageName  图片
 *  @param originRect   原始位置
 *  @param index        标号
 *
 *  @return LWImageModel实例对象
 */
- (instancetype)initWithImageName:(NSString *)imageName
       imageViewSuperView:(UIView *)superView
      positionAtSuperView:(CGRect)positionAtSuperView
                    index:(NSInteger)index;


@end
