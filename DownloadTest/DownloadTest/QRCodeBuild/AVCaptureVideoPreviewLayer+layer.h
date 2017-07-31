//
//  AVCaptureVideoPreviewLayer+layer.h
//  QRcode
//
//  Created by liukhai on 2017/3/14.
//  Copyright © 2017年 liukhai. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>


@interface AVCaptureVideoPreviewLayer (layer)

+ (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayerWithFrame:(CGRect)frame
                                                   rectOfInterest:(CGRect)rectOfInterest
                                                    captureDevice:(AVCaptureDevice *)captureDevice
                                          metadataObjectsDelegate:(id<AVCaptureMetadataOutputObjectsDelegate>)metadataObjectsDelegate;

@end
