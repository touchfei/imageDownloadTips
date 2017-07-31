
//  UIColor+hexColor.m
//  MobileAssistant
//
//  Created by formssi on 2017/4/17.
//  Copyright © 2017年 spreadit. All rights reserved.
//

#import "UIColor+hexColor.h"

@implementation UIColor (hexColor)


+ (UIColor *) colorWithHexString: (NSString *)color{
   return  [self colorWithHexString:color alpha:1.0f];
}


+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)opacity{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:opacity];
}


    
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
    {
        float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
        float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
        float blue = ((float)(hexColor & 0xFF))/255.0;
        return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
    }

    
@end
