//
//  ColorManger.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/26.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "ColorManger.h"

@implementation ColorManger

#define color(r,g,b) colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1

+ (UIColor *)darkPrimaryColor {
    
    return [UIColor color(255,124,0)];
}

+ (UIColor *)primaryColor {
    
    return [UIColor color(255,152,0)];
}

+ (UIColor *)lightPrimaryColor {
    
    return [UIColor color(255,224,178)];
}

+ (UIColor *)textAndIconColor {
    
    return [UIColor color(255,255,255)];
}

+ (UIColor *)accentColor {
    
    return [UIColor color(76,175,80)];
}

+ (UIColor *)primaryTextColor {
    
    return [UIColor color(33,33,33)];
}

+ (UIColor *)secondaryTextColor {
    
    return [UIColor color(114,114,114)];
}

+ (UIColor *)dividerColor {
    
    return [UIColor color(182,182,182)];
}

+ (UIColor *)backGroundColor {
    
    return [UIColor color(255,255,255)];
}
@end
