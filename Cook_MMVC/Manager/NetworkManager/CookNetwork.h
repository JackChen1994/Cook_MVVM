//
//  CookNetwork.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseNetwork.h"
#import "FoodListModel.h"

@interface CookNetwork : BaseNetwork

+ (id)searchFoodWithIndex:(NSInteger)beginIndex foodName:(NSString *)foodName Complete:(void(^)(FoodListModel *foodListModel, NSError *error))complete;

+ (id)getFoodListWithIndex:(NSInteger)beginIndex categoryId:(NSString *)categoryId Complete:(void(^)(FoodListModel *foodListModel, NSError *error))complete;

@end
