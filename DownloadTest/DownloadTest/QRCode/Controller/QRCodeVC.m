//
//  QRCodeVC.m
//  SpreadItApp
//
//  Created by jemy on 2017/6/14.
//  Copyright © 2017年 spreadit. All rights reserved.
//

#import "QRCodeVC.h"
#import "SYQRCodeOverlayView.h"
#import "AVCaptureVideoPreviewLayer+layer.h"
#import "SYQRCodeUtility.h"
#import "QRCodeViewModle.h"

#import "FSProgressViewTool.h"
#import "HudTipView.h"

static NSInteger const HudTipViewDiscontinue = 6000;

@interface QRCodeVC ()<QRCodeViewModleDelegate, HudTipViewDelegate>

@property(nonatomic, strong)QRCodeViewModle *viewModel;

@end

@implementation QRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [self stopSYQRCodeReading];
    
    
    //扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *responseObj = metadataObjects[0];
        //        //org.iso.QRCode
        //        if ([responseObj.type containsString:@"QRCode"]) {
        //
        //        }
        if (responseObj) {
            NSString *strResponse = responseObj.stringValue;
            
            if (strResponse && ![strResponse isEqualToString:@""] && strResponse.length > 0) {
                NSLog(@"qrcodestring==%@",strResponse);
                if( strResponse.length == 21){
                    [self.viewModel submitQRCodeWithString:strResponse];
                    [[FSProgressViewTool shareInstance] showProgressView:self.view message:nil];
                }else{
                    [self ShowErrorView:@"qr_code_fail"];
                }
            }
        }
    }
    
}

#pragma mark - getset
- (QRCodeViewModle *)viewModel{
    
    if(!_viewModel){
        _viewModel = [[QRCodeViewModle alloc] init];
        _viewModel.delegate = self;
        _viewModel.campaignId = _campaignId;
    }
    return _viewModel;
}

#pragma mark - viewModelDelegate

- (void)ShowErrorView:(NSString *)errorMessage{
    
    [[FSProgressViewTool shareInstance] removeProgressView];
    HudTipView *tipView = [HudTipView hudWithTipImg:@"mytasks_qr-no" tipMessage:@[errorMessage] textAlignment:NSTextAlignmentCenter btnName:nil];
    
    
    tipView.frame = [UIScreen mainScreen].bounds;
    tipView.delegate = self;

    [[UIApplication sharedApplication].keyWindow addSubview:tipView];

}

- (void)ShowSuccessView{
    [[FSProgressViewTool shareInstance] removeProgressView];

    HudTipView *tipView = [HudTipView hudWithTipImg:@"mytasks_qr-yes" tipMessage:@[@"task_detail_alert_content_take_some_nice_photos1",@"task_detail_alert_content_take_some_nice_photos2"] textAlignment:NSTextAlignmentCenter btnName:@[@"task_detail_qr_to_campaign"]];
    
    tipView.frame = [UIScreen mainScreen].bounds;

    tipView.delegate = self;

    [[UIApplication sharedApplication].keyWindow addSubview:tipView];
}

- (void)hudTipView:(HudTipView *)hudTipView clickFirstBtn:(UIButton *)btn{
    
    [hudTipView removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)hudTipView:(HudTipView *)hudTipView clickBackBtn:(UIButton *)btn{
    [self performSelector:@selector(startSYQRCodeReading) withObject:nil afterDelay:0.1f];
}
@end
