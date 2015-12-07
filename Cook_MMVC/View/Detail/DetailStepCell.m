//
//  DetailStepCell.m
//  Cook_MMVC
//
//  Created by tarena on 15/11/2.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "DetailStepCell.h"
#import "ColorManger.h"

@implementation DetailStepCell

- (void)awakeFromNib {
    
    [self initColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)initColor {
    //背景
    self.backgroundColor = [ColorManger textAndIconColor];
    //标题
    self.stepTitleLabel.textColor = [ColorManger primaryTextColor];
    //图片
    CALayer *imageLayer = [self.stepImageView layer];
    imageLayer.borderColor = [ColorManger lightPrimaryColor].CGColor;
    imageLayer.borderWidth = 3.0f;
}

@end
