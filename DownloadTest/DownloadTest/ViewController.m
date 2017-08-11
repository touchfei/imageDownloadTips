//
//  ViewController.m
//  DownloadTest
//
//  Created by gaofei on 2017/7/25.
//  Copyright © 2017年 Formssi. All rights reserved.
//

#import "ViewController.h"
#import "SDWebImageManager.h"
#import <objc/runtime.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    // 系统版本在iOS9.0及以上则编译此部分代码
#else
    // 如果低于iOS9.0则编译此部分代码
#endif
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    // 如果选择(iOS Deployment Target)的最低支持版本在iOS7.0及以上才可以使用
    
#endif
    
    if (kCFCoreFoundationVersionNumber <kCFCoreFoundationVersionNumber_iOS_9_0) {
        //系统版本低于iOS9.0
    }
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    int int_ver = [version intValue];
    float float_ver = [version floatValue];
    NSLog(@"%@-%d-%f",version,int_ver,float_ver);
    
    if ([[ [UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        
    }

   NSComparisonResult result = [version compare:@"8.1.0" options:NSNumericSearch];
    NSLog(@"result = %ld",result);
    
    NSOperatingSystemVersion sversion =[[NSProcessInfo processInfo] operatingSystemVersion];
    
    NSLog(@"sversion = %ld,%ld,%ld",sversion.majorVersion, sversion.minorVersion, sversion.patchVersion);
    
    NSOperatingSystemVersion v = (NSOperatingSystemVersion){8,2,0};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:v]) {
        NSLog(@"----");
        // 高于该版本
    }else {
        NSLog(@"+++++");
        // 低于该版本
    }
    
//    result = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:sversion];
    
    
    [version respondsToSelector:@selector(stringWithFormat:)];
    
//    NSString *capitalizedProperty = [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    
    if (class_getProperty([NSString class], "propertyName")) {
        // it has that property!
    }
    
       
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
