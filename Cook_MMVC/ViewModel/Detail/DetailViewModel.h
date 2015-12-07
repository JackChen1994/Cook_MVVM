//
//  DetailViewModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "FoodListModel.h"
#import "CookData.h"

@interface DetailViewModel : BaseViewModel

@property (nonatomic, strong) FoodModel *foodModel;

- (instancetype)initWithFoodModel:(FoodModel *)foodModel;

//数据
- (NSString *)imageURLString;
- (NSString *)title;
- (NSString *)intro;

- (NSString *)stepImageAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)stepTitleAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)countOfIngredients;
- (NSString *)ingredientAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)countOfBurden;
- (NSString *)burdenAtIndexPath:(NSIndexPath *)indexPath;

//缓存
- (BOOL)isCached;
- (void)cache;
- (void)deCache;

@end
