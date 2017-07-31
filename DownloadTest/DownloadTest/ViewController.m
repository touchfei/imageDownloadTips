//
//  ViewController.m
//  DownloadTest
//
//  Created by gaofei on 2017/7/25.
//  Copyright © 2017年 Formssi. All rights reserved.
//

#import "ViewController.h"
#import "SDWebImageManager.h"
#import "QRCodeVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)selectQRBtn:(UIButton *)sender {
    [self show];
    
}


- (void)show{
    QRCodeVC *vc = [[QRCodeVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)loadImg{
    [[SDWebImageManager sharedManager] loadImageWithURL:nil options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
