//
//  LFXImageBrowserViewController.m
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import "LFXImageBrowserViewController.h"
#import "LFXImageBrowserFlowLayout.h"
#import "LFXCollectionViewCell.h"
#import "ImageModel.h"
#import "UIImage+ImageEffects.h"
#import "const.h"


#define kPageControlHeight 40.0f
#define kImageBrowserWidth (SCREEN_WIDTH + 10.0f)
#define kImageBrowserHeight SCREEN_HEIGHT
#define kCellIdentifier @"CellIdentifier"

@interface LFXImageBrowserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,LFXImageItemDelegate>

@property (nonatomic,strong) UIImageView* screenshotImageView; //显示屏幕图片UIImageView
@property (nonatomic,strong) UIImageView* blurImageView;
@property (nonatomic,strong) UIImage* screenshot; //显示屏幕图片UIImage
@property (nonatomic,strong) UICollectionView* collectionView; // 图片UICollectionView
@property (nonatomic,strong) UIPageControl* pageControl; //分页显示器
@property (nonatomic,strong) UIViewController* parentVC;  //父控制器
@property (nonatomic,assign,getter=isFirstShow) BOOL firstShow;//是否第一次显示
@property (strong, nonatomic) LFXImageBrowserFlowLayout *flowLayout; //UICollectionView布局
@end

@implementation LFXImageBrowserViewController

- (instancetype)initWithParentViewController:(UIViewController *)parentVC
                             style:(LFXImageBrowserShowAnimationStyle)style
                       imageModels:(NSArray *)imageModels
                      currentIndex:(NSInteger)index {
    
    self  = [super init];
    if (self) {
        self.parentVC = parentVC;
        self.style = style;
        self.imageModels = imageModels;
        self.currentIndex = index;
        switch (self.style) {
            case LWImageBrowserAnimationStyleScale:
                self.screenshot = [self _screenshotFromView:[UIApplication sharedApplication].keyWindow];
                self.firstShow = YES;
                break;
            default:
                self.firstShow = NO;
                break;
        }
    }
    return self;
}

/**
 *  截取屏幕
 *
 *  @param aView 截取的view
 *
 *  @return 返回截图的view图片
 */
- (UIImage *)_screenshotFromView:(UIView *)aView {
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size,NO,[UIScreen mainScreen].scale);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.screenshotImageView];
    [self.view addSubview:self.blurImageView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    
    //毛玻璃效果
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage* blurImage = [self.screenshot applyBlurWithRadius:20
                                                        tintColor:RGB(0, 0, 0, 0.6)
                                            saturationDeltaFactor:1.4
                                                        maskImage:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            _blurImageView.image = blurImage;
            
            [UIView animateWithDuration:0.1f animations:^{
                _blurImageView.alpha = 1.0f;
            }];
        });
    });
    [self.collectionView setContentOffset:CGPointMake(self.currentIndex * (SCREEN_WIDTH + 10.0f), 0.0f) animated:NO];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _setCurrentItem];
    self.firstShow = NO;
}


- (LFXImageBrowserFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[LFXImageBrowserFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH + 10.0f,self.view.bounds.size.height)
                                             collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.backgroundView = nil;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[LFXCollectionViewCell class]
            forCellWithReuseIdentifier:kCellIdentifier];
    }
    return _collectionView;
}
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f,
                                                                       SCREEN_HEIGHT - kPageControlHeight - 10.0f,
                                                                       SCREEN_WIDTH,
                                                                       kPageControlHeight)];
        _pageControl.numberOfPages = self.imageModels.count;
        _pageControl.currentPage = self.currentIndex;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (UIImageView *)screenshotImageView {
    if (!_screenshotImageView) {
        _screenshotImageView = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
        _screenshotImageView.image = self.screenshot;
    }
    return _screenshotImageView;
}

- (UIImageView *)blurImageView {
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
        _blurImageView.alpha = 0.0f;
    }
    return _blurImageView;
}



#pragma mark
#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LFXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath ];
    cell.imageItem.firstShow = self.isFirstShow;
    cell.imageModel = [self.imageModels objectAtIndex:indexPath.row];
    cell.imageItem.ImageItemDelegate = self;
    return cell;

}

#pragma mark
#pragma mark --- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset / SCREEN_WIDTH;
    self.currentIndex = index;
    self.pageControl.currentPage = self.currentIndex;
    if (self.style == LWImageBrowserAnimationStylePush) {
        self.title = [NSString stringWithFormat:@"%lu/%lu",
                      (unsigned long)((self.collectionView.contentOffset.x / SCREEN_WIDTH) + 1),
                      (unsigned long)self.imageModels.count];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self _setCurrentItem];
}

- (void)_setCurrentItem {
    NSArray* cells = [self.collectionView visibleCells];
    if (cells.count != 0) {
        LFXCollectionViewCell* cell = [cells objectAtIndex:0];
        if (self.currentImageItem != cell.imageItem) {
            self.currentImageItem = cell.imageItem;
//            [self _preDownLoadImageWithIndex:self.currentIndex];
        }
    }
}

/**
 *  预加载当前Index的前后两张图片
 *
 *  @param index 当前的Index
 */
//- (void)_preDownLoadImageWithIndex:(NSInteger)index {
//    SDWebImageManager* manager = [SDWebImageManager sharedManager];
//    if (index + 1 < self.imageModels.count) {
//        ImageModel* nextModel = [self.imageModels objectAtIndex:index + 1];
//        [manager downloadImageWithURL:nextModel.HDURL
//                              options:0
//                             progress:nil
//                            completed:^(UIImage *image,
//                                        NSError *error,
//                                        SDImageCacheType cacheType,
//                                        BOOL finished,
//                                        NSURL *imageURL) {}];
//    }
//    if (index - 1 >= 0) {
//        ImageModel* previousModel = [self.imageModels objectAtIndex:index - 1];
//        [manager downloadImageWithURL:previousModel.HDURL
//                              options:0
//                             progress:nil
//                            completed:^(UIImage *image,
//                                        NSError *error,
//                                        SDImageCacheType cacheType,
//                                        BOOL finished,
//                                        NSURL *imageURL) {}];
//    }
//}


/**
 *  显示控制器
 */
- (void)show {
    switch (self.style) {
        case LWImageBrowserAnimationStylePush: {
            [self.parentVC.navigationController pushViewController:self animated:YES];
        }
            break;
        default: {
            [self.parentVC presentViewController:self animated:NO completion:^{}];
        }
            break;
    }
}


- (void)_hide {
    __weak typeof(self) weakSelf = self;
    switch (self.style) {
        case LWImageBrowserAnimationStylePush: {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default: {
            if (self.currentImageItem.zoomScale != 1.0f) {
                self.currentImageItem.zoomScale = 1.0f;
            }
            [UIView animateWithDuration:0.25f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 weakSelf.blurImageView.alpha = 0.0f;
                                 weakSelf.currentImageItem.imageView.frame = weakSelf.currentImageItem.imageModel.originPosition;
                             } completion:^(BOOL finished) {
                                 [weakSelf dismissViewControllerAnimated:NO completion:^{}];
                             }];
        }
            break;
    }
}


#pragma mark - LWImageItemDelegate

- (void)didClickedItemToHide {
    if (self.style == LWImageBrowserAnimationStyleScale) {
        [self _hide];
    }
    else {
        [self _hideNavigationBar];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)_hideNavigationBar {
    if (self.navigationController.navigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
