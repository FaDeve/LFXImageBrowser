//
//  LFXCollectionViewCell.h
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFXImageItem.h"
@class ImageModel;
@interface LFXCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) ImageModel *imageModel;
@property (nonatomic,strong) LFXImageItem *imageItem;
@end
