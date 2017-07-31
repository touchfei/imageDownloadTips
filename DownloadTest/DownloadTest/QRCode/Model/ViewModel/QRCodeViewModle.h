//
//  QRCodeViewModle.h
//  SpreadItApp
//
//  Created by jemy on 2017/6/14.
//  Copyright © 2017年 spreadit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QRCodeViewModleDelegate <NSObject>

@optional

/**
 扫描二维码成功，显示成功页面
 */
- (void)ShowSuccessView;

/**
 扫描二维码失败，显示失败页面
 */
- (void)ShowErrorView:(NSString *)errorMessage;

//活动中止弹出的提示框
- (void)showDiscontinueViewWithTitle:(NSString *)title content:(NSString *)content;

@end
@interface QRCodeViewModle : NSObject

@property(nonatomic, strong)NSString *campaignId;
@property(nonatomic, weak)id<QRCodeViewModleDelegate> delegate;


- (void)submitQRCodeWithString:(NSString *)QRCodeMessage;

@end
