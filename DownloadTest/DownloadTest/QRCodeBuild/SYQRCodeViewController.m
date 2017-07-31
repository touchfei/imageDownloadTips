//
//  SYQRCodeViewController.m
//  SYQRCodeDemo
//


#import "SYQRCodeViewController.h"
#import "SYQRCodeOverlayView.h"
#import "AVCaptureVideoPreviewLayer+layer.h"
#import "SYQRCodeUtility.h"
#import "FSAlertTools.h"

@interface SYQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) AVCaptureSession *qrSession;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *qrVideoPreviewLayer;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) NSTimer *lineTimer;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation SYQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
//    [self setNavigationBarTitleViewWithTitle:FSLocalizedString(@"task_detail_title_qr_code")];
    
    //权限受限
    if (![SYQRCodeUtility canAccessAVCaptureDeviceForMediaType:AVMediaTypeVideo]) {
        [self showUnAuthorizedTips:YES];
        return;
    }
    
    [self displayScanView];
   
}

- (void)displayScanView {
    //没权限显示权限受限
    if ([self loadCaptureUI]) {
        [self setOverlayPickerView];
        [self startSYQRCodeReading];
    }
    else {
    }
}

- (void)showUnAuthorizedTips:(BOOL)flag {
//    if (!_tipsLabel) {
//        _tipsLabel = [[UILabel alloc] init];
//        _tipsLabel.frame = CGRectMake(8, 64, self.view.frame.size.width - 16, 300);
//        _tipsLabel.textAlignment = NSTextAlignmentCenter;
//        _tipsLabel.numberOfLines = 0;
//        _tipsLabel.font = [UIFont systemFontOfSize:16];
//        _tipsLabel.textColor = [UIColor blackColor];
//        _tipsLabel.userInteractionEnabled = YES;
//        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
//        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
//        _tipsLabel.text = [NSString stringWithFormat:@"请在%@的\"设置-隐私-相机\"选项中，\r允许%@访问你的相机。",[UIDevice currentDevice].model,appName];
//        [self.view addSubview:_tipsLabel];
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTipsTap)];
//        [_tipsLabel addGestureRecognizer:tap];
//    }
//    
//    _tipsLabel.hidden = !flag;
    
    NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
    [[FSAlertTools sharedInstance] showAlertWithMessage:[NSString stringWithFormat:@"请在%@的\"设置-隐私-相机\"选项中，\r允许%@访问你的相机。",[UIDevice currentDevice].model,appName] inViewController:self];
}

- (void)_handleTipsTap {
    [SYQRCodeUtility openSystemSettings];
}

- (BOOL)loadCaptureUI {
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (![_captureDevice hasTorch]) {
        [SYQRCodeUtility showAlertWithTitle:@"提示" message:@"当前设备没有闪光灯"];
    }

    _qrVideoPreviewLayer = [AVCaptureVideoPreviewLayer captureVideoPreviewLayerWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) rectOfInterest:[SYQRCodeUtility getReaderViewBoundsWithSize:CGSizeMake(kReaderViewWidth, kReaderViewHeight)] captureDevice:_captureDevice metadataObjectsDelegate:self];
    
    if (!_qrVideoPreviewLayer) {
        return NO;
    }    
    return YES;
}

- (void)setOverlayPickerView {
    SYQRCodeOverlayView *vOverlayer = [[SYQRCodeOverlayView alloc] initWithFrame:self.view.bounds basedLayer:_qrVideoPreviewLayer];
    [self.view addSubview:vOverlayer];
    
    //添加过渡动画
    [self.view.layer insertSublayer:_qrVideoPreviewLayer atIndex:0];    
    [_qrVideoPreviewLayer addAnimation:[SYQRCodeUtility zoomOutAnimation] forKey:nil];
}

- (void)gotoImagePickerController {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)turnOnTorch:(BOOL)on {
    if (_captureDevice) {
        [_captureDevice lockForConfiguration:nil];
        if (on) {
            [_captureDevice setTorchMode:AVCaptureTorchModeOn];
        }
        else {
            [_captureDevice setTorchMode: AVCaptureTorchModeOff];
        }
        
        [_captureDevice unlockForConfiguration];
    }
}

#pragma mark - Button Event

- (void)btnCloseClick:(UIButton *)sender {
    [self stopSYQRCodeReading];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [self stopSYQRCodeReading];

    BOOL fail = YES;
    NSLog(@"扫描结束");
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
                
                if ([strResponse hasPrefix:@"http"]) {
                    fail = NO;                    
                    if (self.SYQRCodeSuccessBlock) {
                        self.SYQRCodeSuccessBlock(self, strResponse);
                    }
                }
            }
        }
    }
    
    if (fail) {
        if (self.SYQRCodeFailBlock) {
            self.SYQRCodeFailBlock(self);
        }
    }
}

#pragma mark - startSYQRCodeReading

- (void)startSYQRCodeReading {

//    if (!_line) {
//        //画中间的基准线
//        _line = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300) / 2.0, kLineMinY, 300, 12 * 300 / 320.0)];
//        [_line setImage:[UIImage imageNamed:@"QRCodeLine"]];
//        [_qrVideoPreviewLayer addSublayer:_line.layer];
//    }
    _qrSession = _qrVideoPreviewLayer.session;

    _lineTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 20 target:self selector:@selector(animationLine) userInfo:nil repeats:YES];
    [_qrSession startRunning];
    
    NSLog(@"start reading....");
}

- (void)stopSYQRCodeReading {
    [self turnOnTorch:NO];

    if (_lineTimer) {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
    
    if (_qrSession) {
        [_qrSession stopRunning];
        _qrSession = nil;
    }

    NSLog(@"stop reading");
}

- (void)cancleSYQRCodeReading {
    [self stopSYQRCodeReading];
    
    if (self.SYQRCodeCancleBlock) {
        self.SYQRCodeCancleBlock(self);
    }
    NSLog(@"cancle reading");
}

#pragma mark - animationLine

- (void)animationLine {
    __block CGRect frame = _line.frame;
    
    static BOOL flag = YES;
    
    if (flag) {
        frame.origin.y = kLineMinY;
        flag = NO;
        
        [UIView animateWithDuration:1.0 / 20 animations:^{
            
            frame.origin.y += 5;
            _line.frame = frame;
            
        } completion:nil];
    }
    else {
        if (_line.frame.origin.y >= kLineMinY) {
            if (_line.frame.origin.y >= kLineMaxY - 12) {
                frame.origin.y = kLineMinY;
                _line.frame = frame;
                
                flag = YES;
            }
            else {
                [UIView animateWithDuration:1.0 / 20 animations:^{
                    frame.origin.y += 5;
                    _line.frame = frame;
                } completion:nil];
            }
        }
        else {
            flag = !flag;
        }
    }
    
    //NSLog(@"_line.frame.origin.y==%f",_line.frame.origin.y);
}

- (void)dealloc {
    NSLog(@"SYQRCodeViewController dealloc");
    [self stopSYQRCodeReading];
}


@end
