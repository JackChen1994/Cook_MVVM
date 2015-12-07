//
//  ImageScrollerView.h
//  Cook_MMVC
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollerView : UIView

@property (nonatomic, strong)NSArray *array;

+ (instancetype)imageScrollerViewWithImageURLs:(NSArray *)imageURLs;

+ (instancetype)imageScrollerViewWithImageURLs:(NSArray *)imageURLs duration:(CGFloat )duration;

- (instancetype)initWithImageURLs:(NSArray *)imageURLs duration:(CGFloat )duration;

- (void)setImageURLs:(NSArray *) imageURLs duration:(NSInteger) duration;

@end
