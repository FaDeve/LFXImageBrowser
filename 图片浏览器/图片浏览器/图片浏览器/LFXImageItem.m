//
//  LFXImageItem.m
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import "LFXImageItem.h"
#import "ImageModel.h"
#import "const.h"

const CGFloat kMaximumZoomScale = 3.0f;
const CGFloat kMinimumZoomScale = 1.0f;
const CGFloat kDuration = 0.18f;



@interface LFXImageItem ()<UIScrollViewDelegate>

@end

@implementation LFXImageItem

/* 初始化 */
- (instancetype) init {
    self = [super init];
    if (self) {
        
        //初始化子视图
        [self _initWithSubviews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //初始化子视图
        [self _initWithSubviews];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化子视图
        [self _initWithSubviews];
    }
    return self;
}

/**
 *  初始化子视图
 */
- (void)_initWithSubviews {
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.maximumZoomScale = kMaximumZoomScale;
    self.minimumZoomScale = kMinimumZoomScale;
    self.zoomScale = 1.0f;
    [self addSubview:self.imageView];
    
    //添加点击事件
    [self setUpGestures];
    
}

#pragma mark
#pragma mark -- 懒加载
-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}


//模型数据
- (void)setImageModel:(ImageModel *)imageModel {
    if (_imageModel != imageModel) {
        _imageModel = imageModel;
    }
    self.zoomScale = 1.0f;
    self.imageView.image = [UIImage imageNamed:imageModel.imageName];
    self.imageView.center = self.center;
    
    self.imageView.frame = [self calculateDestinationFrameWithSize:self.imageView.image.size];
//    //是否第一次加载
//    if (self.isFirstShow) {
//        [self loadHdImage:YES];
//    }
//    else {
//        [self loadHdImage:NO];
//    }
}




/*
- (void)loadHdImage:(BOOL)animated {
    //是否有略缩图，没有就加载占位图
    if (self.imageModel.thumbnailImage == nil) {
        self.imageView.image = self.imageModel.placeholder;
        self.imageView.frame = [self calculateDestinationFrameWithSize:self.imageModel.placeholder.size];
        return;
    }
    //获取图片大小
    CGRect destinationRect = [self calculateDestinationFrameWithSize:self.imageModel.thumbnailImage.size];
    //管理对象SDWebImageManager
    SDWebImageManager* manager = [SDWebImageManager sharedManager]
    //是否已经下载过高清图
    BOOL isImageCached = [manager cachedImageExistsForURL:self.imageModel.HDURL];
    __weak typeof(self) weakSelf = self;
    //还未下载的图片
    if (!isImageCached) {
        self.imageView.image = self.imageModel.thumbnailImage;
        if (animated) {
            self.imageView.frame = self.imageModel.originPosition;
            [UIView animateWithDuration:0.18f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 weakSelf.imageView.center = weakSelf.center;
                             } completion:^(BOOL finished) {
                                 if (finished) {
                                     [weakSelf downloadImageWithDestinationRect:destinationRect];
                                 }
                             }];
        } else {
            weakSelf.imageView.center = weakSelf.center;
            [self downloadImageWithDestinationRect:destinationRect];
        }
    } else { //已经下载的图片
        if (animated) {
            self.imageView.frame = self.imageModel.originPosition;
            [self.imageView sd_setImageWithURL:self.imageModel.HDURL];
            [UIView animateWithDuration:kDuration
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 weakSelf.imageView.frame = destinationRect;
                             } completion:^(BOOL finished) {
                             }];
        } else {
            [self.imageView sd_setImageWithURL:self.imageModel.HDURL];
            self.imageView.frame = destinationRect;
        }
    }
}

//下载图片
- (void)downloadImageWithDestinationRect:(CGRect)destinationRect {
    __weak typeof(self) weakSelf = self;
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [manager downloadImageWithURL:self.imageModel.HDURL
                              options:options
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 //TODO:加载动画
                                 
                             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                 if (finished) {
                                     weakSelf.imageView.image = image;
                                     weakSelf.imageModel.thumbnailImage = image;
                                     // 通知刷新
                                     if ([self.eventDelegate respondsToSelector:@selector(didFinishRefreshThumbnailImageIfNeed)]) {
                                         [self.eventDelegate didFinishRefreshThumbnailImageIfNeed];
                                     }
                                     [UIView animateWithDuration:0.2f animations:^{
                                         weakSelf.imageView.frame = destinationRect;
                                     } completion:^(BOOL finished) {
                                     }];
                                 }
                             }];
    });
}

*/

- (CGRect)calculateDestinationFrameWithSize:(CGSize)size{
    CGRect rect = CGRectMake(0.0f,
                             (SCREEN_HEIGHT - size.height * SCREEN_WIDTH/size.width)/2,
                             SCREEN_WIDTH,
                             size.height * SCREEN_WIDTH/size.width);
    return rect;
}


/**
 *  点击事件
 */
- (void)setUpGestures {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    doubleTap.numberOfTapsRequired = 2;
    twoFingTap.numberOfTouchesRequired = 2;
    [self addGestureRecognizer:singleTap];
    [self.imageView addGestureRecognizer:doubleTap];
    [self.imageView addGestureRecognizer:twoFingTap];
    // 关键在这一行，如果双击确定偵測失败才會触发单击
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    
}

#pragma mark
#pragma mark --- 手势点击事件
- (void)handleSingleTap:(UITapGestureRecognizer *)singleTap {
    if (singleTap.numberOfTapsRequired == 1) {
        if ([self.ImageItemDelegate respondsToSelector:@selector(didClickedItemToHide)]) {
            [self.ImageItemDelegate didClickedItemToHide];
        }
    }

}
- (void)handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    if (doubleTap.numberOfTapsRequired == 2) {
        if(self.zoomScale == 1){
            float newScale = [self zoomScale] * 2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[doubleTap locationInView:self]];
            [self zoomToRect:zoomRect animated:YES];
        } else {
            float newScale = [self zoomScale] / 2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[doubleTap locationInView:self]];
            [self zoomToRect:zoomRect animated:YES];
        }
    }

}

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width = [self frame].size.width / scale;
    zoomRect.origin.x = center.x - zoomRect.size.width / 2;
    zoomRect.origin.y = center.y - zoomRect.size.height / 2;
    return zoomRect;
}
- (void)handleTwoFingTap:(UITapGestureRecognizer *)twoFingTap {
    float newScale = [self zoomScale]/2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[twoFingTap locationInView:self]];
    [self zoomToRect:zoomRect animated:YES];
}



#pragma mark
#pragma mark --- UIScrollViewDelegate
/**
 *  缩放对象
 *
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

/**
 *  缩放结束
 *
 */
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale + 0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

/**
 *  让UIImageView在UIScrollView缩放后居中显示
 *
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end
