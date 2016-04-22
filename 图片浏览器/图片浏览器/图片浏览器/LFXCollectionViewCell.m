//
//  LFXCollectionViewCell.m
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import "LFXCollectionViewCell.h"
#import "const.h"




@implementation LFXCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        self.imageItem = [[LFXImageItem alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.contentView addSubview:self.imageItem];
    }
    return self;
}

- (void)setImageModel:(ImageModel *)imageModel {
    if (_imageModel != imageModel) {
        _imageModel = imageModel;
    }
    self.imageItem.imageModel = self.imageModel;
}

@end
