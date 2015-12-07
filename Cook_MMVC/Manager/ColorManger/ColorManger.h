//
//  ColorManger.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/26.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseColor.h"

@interface ColorManger : BaseColor

//深基色
+ (UIColor *)darkPrimaryColor;
//基色
+ (UIColor *)primaryColor;
//浅基色
+ (UIColor *)lightPrimaryColor;
//文字图标
+ (UIColor *)textAndIconColor;
//强调色
+ (UIColor *)accentColor;
//文字色
+ (UIColor *)primaryTextColor;
//第二文字色
+ (UIColor *)secondaryTextColor;
//分色
+ (UIColor *)dividerColor;

+ (UIColor *)backGroundColor;

@end
