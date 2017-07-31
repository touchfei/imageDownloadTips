//
//  ViewController.h
//  MobileAssistant
//
//  Created by formssi on 2017/4/17.
//  Copyright © 2017年 spreadit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

@interface UIColor (hexColor)


/**
 16进制颜色转换为Color

 @param color 16进制颜色字符串（可以包含#,0X,可以不包含）
 @return UIcolor对象
 */
+ (UIColor *) colorWithHexString: (NSString *)color;


/**
 16进制颜色转换为Color

 @param color 16进制颜色字符串（可以包含#,0X,可以不包含）
 @param opacity 不透明度（0~1）
 @return UIcolor对象
 */
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)opacity;


/**
 16进制颜色转换为Color

 @param hexColor 16进制颜色（不包含#,0X）
 @param opacity 不透明度（0~1）
 @return UIcolor对象
 */
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
