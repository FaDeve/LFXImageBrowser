//
//  ImageModel.m
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import "ImageModel.h"
#import "const.h"


@implementation ImageModel

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
                  index:(NSInteger)index {
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.index = index;
        if (superView != nil) {
            UIWindow* window = [UIApplication sharedApplication].keyWindow;
            CGRect originRect = [superView convertRect:positionAtSuperView toView:window];
            self.originPosition = originRect;
        }
        else {
            self.originPosition = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0);
        }

    }
    
    return self;
}


@end
