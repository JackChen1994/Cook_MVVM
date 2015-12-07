//
//  FoodListModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "FoodListModel.h"

@implementation FoodListModel

+ (id)parse:(NSDictionary *)responseObj{
    
    if (![responseObj[@"resultcode"] isEqualToString:@"200"]) {
        return nil;
    }
    FoodListModel *model = [super parse:responseObj];
    [model setValuesForKeysWithDictionary:responseObj[@"result"]];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dic in responseObj[@"result"][@"data"]) {
        [arr addObject:[FoodModel parse:dic]];
    }
    model.data = [arr copy];
    return model;
}

@end


@implementation FoodModel

+ (id)parse:(NSDictionary *)responseObj {
    FoodModel *model = [[FoodModel alloc]init];
    model.foodDictionary = responseObj;
    [model setValuesForKeysWithDictionary:responseObj];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dic in responseObj[@"steps"]) {
        [arr addObject:[stepModel parse:dic]];
    }
    model.steps = [arr copy];
    return model;
}

@end


@implementation stepModel

@end