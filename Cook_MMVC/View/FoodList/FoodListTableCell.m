//
//  FoodListTableCell.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "FoodListTableCell.h"
#import "ColorManger.h"

@implementation FoodListTableCell

- (void)awakeFromNib {
    
    [self setColor];
}

- (void)setColor {
    CALayer *imageLayer = self.foodImageView.layer;
    imageLayer.borderWidth = 2;
    imageLayer.borderColor = [ColorManger lightPrimaryColor].CGColor;
    
}

@end
