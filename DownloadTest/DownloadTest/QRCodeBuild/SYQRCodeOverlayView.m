//
//  UCQRCodeOverlayView.m
//  SYQRCodeDemo
//

#import "SYQRCodeOverlayView.h"
#import "SYQRCodeUtility.h"
#import "Masonry.h"
#import "UIColor+hexColor.h"


#define FontMedium(value) [UIFont fontWithName:@"Avenir-Medium" size:(value)]
#define FontHeavy(value)  [UIFont fontWithName:@"Avenir-Heavy" size:(value)]

@interface SYQRCodeOverlayView ()

@property (nonatomic, strong) CALayer *basedLayer;

@end

@implementation SYQRCodeOverlayView

- (instancetype)initWithFrame:(CGRect)frame
                   basedLayer:(CALayer *)basedLayer {
    if (self = [super initWithFrame:frame]) {
        _basedLayer = basedLayer;
        [self createSubViews];
    }
    
    return self;
}

- (void)createSubViews {

    
    UIView *bottomView = ({
        
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-64);
            make.height.equalTo(@80);
        }];
        
        view.backgroundColor = [UIColor colorWithRed:(3*16 + 12)/255.0 green:(3*16 + 12)/255.0 blue:(3*16 + 12)/255.0 alpha:1];
        bottomView = view;
        
    });
    
    UIView *bottomContentView = ({
        
        UIView *view = [[UIView alloc] init];
        [bottomView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bottomView);
        }];
        
        view;
    });
    
    UIImageView *scanImg = ({
        
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mytasks_qr"]];
        [bottomContentView addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomContentView);
            make.centerX.equalTo(bottomContentView);
        }];
        
        
        imgV;
    });
    
    UILabel *bottomTipLabel = ({
        
        UILabel *label = [[UILabel alloc] init];
        [bottomContentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(bottomContentView);
            make.top.equalTo(scanImg.mas_bottom).offset(5);
        }];
        
//        label.font = FontMedium(14);
//        label.text = FSLocalizedString(@"task_detail_btn_scan_a_qr_code");
//        label.textColor = [UIColor colorWithHexString:@"f3cf00"];
        
        label.font = FontMedium(14);
//        label.text = FSLocalizedString(@"task_detail_btn_scan_a_qr_code");
        label.text = @"Scan a QR code";
        label.textColor = [UIColor colorWithHexString:@"f3cf00"];
        bottomTipLabel = label;
    });
    
    UIImageView *scanQRImgView = ({
        
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mytasks_square"]];
        [self addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-40-32);
        }];
        
        imgV;
    });
    
    UIView *topHudView = ({
        
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(scanQRImgView.mas_top);
        }];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        topHudView = view;
    });
    
    UIView *leftHudView = ({
        
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.bottom.equalTo(scanQRImgView);
            make.right.equalTo(scanQRImgView.mas_left);
        }];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

        leftHudView = view;
    });
    
    UIView *rightHudView = ({
        
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.bottom.equalTo(scanQRImgView);
            make.left.equalTo(scanQRImgView.mas_right);
        }];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        rightHudView = view;
    });
    
    UIView *bottomHudView = ({
        
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(scanQRImgView.mas_bottom);
            make.bottom.equalTo(bottomView.mas_top);
        }];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        bottomHudView = view;
    });
    
    UILabel *tipLabel1 = ({
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scanQRImgView.mas_bottom).offset(15);
            make.centerX.equalTo(self);
            
        }];
        label.font = FontMedium(14);
//        label.text = FSLocalizedString(@"task_detail_qr_scan_title1");
        label.text = @"After you pick up the product,";
        label.textColor = [UIColor whiteColor];
        label;
    });
    
    UILabel *tipLabel2 = ({
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipLabel1.mas_bottom).offset(0);
            make.centerX.equalTo(self);
            
        }];
        label.textColor = [UIColor whiteColor];

        label.font = FontMedium(14);
//        label.text = FSLocalizedString(@"task_detail_qr_scan_title2");
        label.text = @"please scan the QR code provided by the staff.";
        
        tipLabel2 = label;
    });
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
