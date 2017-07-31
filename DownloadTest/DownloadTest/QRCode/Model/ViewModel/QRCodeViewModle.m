//
//  QRCodeViewModle.m
//  SpreadItApp
//
//  Created by jemy on 2017/6/14.
//  Copyright © 2017年 spreadit. All rights reserved.
//

#import "QRCodeViewModle.h"
#import "SubmitQRCodeRequestModel.h"

#define SubmitQRCodeListTag 1500
static NSInteger const requestReturnCode60050 = 60050; //活动已结束
static NSInteger const requestReturnCode60051 = 60051; //活动已中

@implementation QRCodeViewModle

- (void)submitQRCodeWithString:(NSString *)QRCodeMessage{
    
//    SubmitQRCodePara *para = [[SubmitQRCodePara alloc] init];
//    para.campaignId = self.campaignId;
//    para.QRcodeInfo = QRCodeMessage;
//    
//    FSAppRequestManager *manager = [FSAppRequestManager shareInstance];
//    [manager requestSubmitQRCodeWithPara:para tag:SubmitQRCodeListTag responseModelClass:[SubmitQRCodeRequestModel class] requestResponse:^(FSDynamicPackage *package) {
//        
//        [[FSResonpseDataFilter shareFilterInstance] useFilter:package delegate:self];
//    }];

}

//- (void)showErrorViewWithPackage:(FSNAPackage*)package{
//    
//    NSString *errorMessage;
//    
//    SubmitQRCodeRequestModel *reqModel = (SubmitQRCodeRequestModel *)package.response.reponseModel;
//    
//    if(reqModel.rtnCode.integerValue == 60005){
//    
//        errorMessage = FSLocalizedString(@"qr_code_fail");
//    }else if(reqModel.rtnCode.integerValue == 60037){
//        
//        errorMessage = FSLocalizedString(@"qr_code_taked");
//    }else if(reqModel.rtnCode.integerValue == 60040){
//        
//        errorMessage = FSLocalizedString(@"qr_code_unactive");
//    }else if([reqModel.rtnCode intValue] == requestReturnCode60050){
//        
//        if (_delegate && [_delegate respondsToSelector:@selector(ShowErrorView:)]){
//            
//            [_delegate ShowErrorView:FSLocalizedString(@"active_expired")];
//        }
//    }else if([reqModel.rtnCode intValue] == requestReturnCode60051){
//        
//        if (_delegate && [_delegate respondsToSelector:@selector(showDiscontinueViewWithTitle:content:)]){
//            
//            [_delegate showDiscontinueViewWithTitle:FSLocalizedString(@"sorry_captical") content:FSLocalizedString(@"task_detail_alert_suspend_content_has_no_submit_url")];
//        }
//    }
//    
//    if([self.delegate respondsToSelector:@selector(ShowErrorView:)]){
//        [self.delegate ShowErrorView:errorMessage];
//    }
//
//}

#pragma mark - requestDelegate
//- (void)requstSuccess:(FSNAPackage*)package {
//    NSLog(@"success");
//    
//    if([self.delegate respondsToSelector:@selector(ShowSuccessView)]){
//        [self.delegate ShowSuccessView];
//    }
//}
//
//- (void)requestSuccessButNoData:(FSNAPackage*)package {
//    DLog(@"requestSuccessButNoData");
//    [self showErrorViewWithPackage:package];
//}
//
//- (void)requestSuccessByReturnFail:(FSNAPackage*)package {
//    DLog(@"requestSuccessByReturnFail");
//    [self showErrorViewWithPackage:package];
//
//}
//
//- (void)requestError:(FSNAPackage*)package {
//    DLog(@"requestError");
//    [self showErrorViewWithPackage:package];
//}

@end
