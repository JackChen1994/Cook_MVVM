//
//  FoodListCollectionCell.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "FoodListCollectionCell.h"
#import "ColorManger.h"

@implementation FoodListCollectionCell

- (void)awakeFromNib {
    
    CALayer *layer = self.foodImageView.layer;
    layer.borderColor = [ColorManger lightPrimaryColor].CGColor;
    layer.borderWidth = 2;
    
    self.layer.shadowColor = [ColorManger primaryColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.5;
}

@end
