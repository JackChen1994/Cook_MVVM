//
//  TableViewCell.h
//  Cook_MMVC
//
//  Created by tarena on 15/11/30.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodListModel.h"

@protocol TableViewCellDelegate <NSObject>

@required
- (void)clickCollectionCell:(FoodModel *)foodModel;

@end

@interface TableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) id<TableViewCellDelegate> myDelegate;

@property (nonatomic, strong)NSArray *imageURLs;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)NSArray *foodList;

- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(void (^)(id obj))block;

@end
