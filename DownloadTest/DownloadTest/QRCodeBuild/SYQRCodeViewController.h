//
//  SYQRCodeViewController.h
//  SYQRCodeDemo
//


#import <UIKit/UIKit.h>

@interface SYQRCodeViewController : UIViewController

/**SYQRCodeCancleBlock */
@property (nonatomic, copy) void (^SYQRCodeCancleBlock) (SYQRCodeViewController *);

/**SYQRCodeSuncessBlock */
@property (nonatomic, copy) void (^SYQRCodeSuccessBlock) (SYQRCodeViewController *, NSString *);

/**SYQRCodeFailBlock */
@property (nonatomic, copy) void (^SYQRCodeFailBlock) (SYQRCodeViewController *);



- (void)stopSYQRCodeReading;
- (void)startSYQRCodeReading;

@end
