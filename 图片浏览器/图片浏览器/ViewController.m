//
//  ViewController.m
//  图片浏览器
//
//  Created by apple on 22/4/16.
//  Copyright © 2016年 LFX. All rights reserved.
//

#import "ViewController.h"
#import "ImageModel.h"
#import "LFXImageBrowserViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *imageA;
@property (strong, nonatomic) NSArray *imagePostionArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *imageA = @[@"btn0_highlight.png",@"btn1_highlight.png",@"btn2_highlight.png",@"btn3_highlight.png",@"btn4_highlight.png",@"btn5_highlight.png",@"btn6_highlight.png",@"btn7_highlight.png",@"btn8_highlight.png"];
    self.imageA = imageA;
    //imgs
    NSInteger imageCount = [imageA count];
    NSMutableArray* tmpArray = [[NSMutableArray alloc] initWithCapacity:imageCount];
    NSInteger row = 0;
    NSInteger column = 0;
    for (NSInteger i = 0; i < imageCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageA[i]]]];
        imageView.tag = 1 + i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction:)];
        [imageView addGestureRecognizer:tap];
        [self.view addSubview:imageView];
        CGRect imageRect = CGRectMake(60.0f + (column * 105.0f),
                                      60.0f  + (row * 105.0f),
                                      100.0f,
                                      100.0f);
        imageView.frame = imageRect;
        NSString* rectString = NSStringFromCGRect(imageRect);
        [tmpArray addObject:rectString];
        column = column + 1;
        if (column > 2) {
            column = 0;
            row = row + 1;
        }
    }
    CGFloat imagesHeight = 0.0f;
    row < 3 ? (imagesHeight = (row + 1) * 105.0f):(imagesHeight = row  * 105.0f);
    self.imagePostionArray = tmpArray;
}

- (void)tapImageViewAction:(UITapGestureRecognizer *)tap {
    UIImageView *image = (UIImageView *)tap.view;
     NSInteger count = self.imageA.count;
     NSMutableArray* tmp = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger i = 0; i < count; i ++) {
        ImageModel *imageModel  = [[ImageModel alloc] initWithImageName:self.imageA[i] imageViewSuperView:self.view positionAtSuperView:CGRectFromString(self.imagePostionArray[i]) index:image.tag - 1];
        
        [tmp addObject:imageModel];
    }
    LFXImageBrowserViewController* imageBrowser = [[LFXImageBrowserViewController alloc] initWithParentViewController:self style:LWImageBrowserAnimationStyleScale imageModels:tmp  currentIndex:image.tag - 1];
    [imageBrowser show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
