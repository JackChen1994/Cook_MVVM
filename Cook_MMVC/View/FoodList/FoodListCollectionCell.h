//
//  FoodListCollectionCell.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodListCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;

@end
