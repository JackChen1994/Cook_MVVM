//
//  CookNetwork.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CookNetwork.h"

//NSString *const myKey = @"323afe0cf720629e2b973c213d4c2526";
NSString *const myKey = @"57cdc13a6eff0bfa4359bce54c6fd98b";

@implementation CookNetwork

+ (id)searchFoodWithIndex:(NSInteger)beginIndex foodName:(NSString *)foodName Complete:(void (^)(FoodListModel *, NSError *))complete{
    NSString *path = @"http://apis.juhe.cn/cook/query";
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:myKey forKey:@"key"];
    [params setObject:foodName forKey:@"menu"];
    [params setObject:@(beginIndex) forKey:@"pn"];
    [params setObject:@"20" forKey:@"rn"];
    [params setObject:@"1" forKey:@"albums"];
    
    return [self Get:path parameters:params completeHandle:^(id responseObj, NSError *error) {
        complete([FoodListModel parse:responseObj], error);
    }];
}

+ (id)getFoodListWithIndex:(NSInteger)beginIndex categoryId:(NSString *)categoryId Complete:(void (^)(FoodListModel *, NSError *))complete {
    NSString *path = @"http://apis.juhe.cn/cook/index";
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:myKey forKey:@"key"];
    [params setObject:categoryId forKey:@"cid"];
    [params setObject:@(beginIndex) forKey:@"pn"];
    [params setObject:@"20" forKey:@"rn"];
    
    return [self Get:path parameters:params completeHandle:^(id responseObj, NSError *error) {
        complete([FoodListModel parse:responseObj], error);
    }];
}

@end
