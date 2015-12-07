//
//  FavoritesViewModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "FoodListModel.h"
#import "CookData.h"

@interface FavoritesViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *foodList;

- (void)getCacheFoodListCompleteWithError:(void(^)(NSError *error))complete;

- (void)deleteFoodAtIndex:(NSInteger )index;

- (NSString *)imageURLStringAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;

- (FoodModel *)foodModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)introAtIndexPath:(NSIndexPath *)indexPath;
@end
