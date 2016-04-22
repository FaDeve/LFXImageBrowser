//
//  LFXImageBrowserFlowLayout.m
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import "LFXImageBrowserFlowLayout.h"
#import "const.h"



@implementation LFXImageBrowserFlowLayout
-(instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(SCREEN_WIDTH + 10.0f, SCREEN_HEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0.0f;
        self.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }
    return self;
}

@end
