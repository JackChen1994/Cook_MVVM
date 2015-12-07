//
//  MainCollectionCell.m
//  Cook_MMVC
//
//  Created by tarena on 15/12/1.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MainCollectionCell.h"
#import "ColorManger.h"

@implementation MainCollectionCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [ColorManger darkPrimaryColor];
    CALayer *layer = self.foodImageView.layer;
    layer.cornerRadius = 8;
}

@end
