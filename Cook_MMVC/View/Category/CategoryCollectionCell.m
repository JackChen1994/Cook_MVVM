//
//  CategoryCollectionCell.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/26.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CategoryCollectionCell.h"

@implementation CategoryCollectionCell

- (void)awakeFromNib {
    self.titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
    self.titleLabel.text = @"中文\n中文";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    //圆角
    self.layer.cornerRadius = 20;
}



@end
