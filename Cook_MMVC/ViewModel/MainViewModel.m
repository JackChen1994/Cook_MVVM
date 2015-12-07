//
//  MainViewModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/11/30.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MainViewModel.h"
#import "CookNetwork.h"
#import "CookData.h"

@implementation MainViewModel

- (NSArray *)imageURLs {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (FoodModel *food in self.foodList) {
        NSString *URLString = food.albums.firstObject;
        [array addObject:[NSURL URLWithString:URLString]];
    }
    return [array copy];
}

- (NSMutableArray *)foodList {
    if (!_foodList) {
        _foodList = [[NSMutableArray alloc]init];
    }
    return _foodList;
}

- (void)refreshHeadWithComplete:(void (^)(NSError *error))complete {
    NSURLSessionTask *task = [CookNetwork getFoodListWithIndex:0 categoryId:@"73" Complete:^(FoodListModel *foodListModel, NSError *error) {
        if (!error) {
            self.foodListModel = foodListModel;
            [self.foodList removeAllObjects];
            for (int i=0; i<5; i++) {
                [self.foodList addObject:self.foodListModel.data[i]];
            }
        }
        complete(error);
    }];
    [task resume];
}

- (void)refreshSceneWithComplete:(void (^)(NSError *))complete {
    [_sceneTask cancel];
    _sceneTask = [CookNetwork getFoodListWithIndex:0 categoryId:[self sceneCid] Complete:^(FoodListModel *foodListModel, NSError *error) {
        if (!error) {
            self.sceneFoodListModel = foodListModel;
            self.sceneFoodList = [foodListModel.data copy];
        }
        complete(error);
    }];
    [_sceneTask resume];
}

- (void)refreshRecommendWithComplete:(void (^)(NSError *))complete {
//    NSInteger random = arc4random()%360;
//    NSString *randomCid = [NSString stringWithFormat:@"%ld",random];
    _sceneTask = [CookNetwork getFoodListWithIndex:0 categoryId:@"211" Complete:^(FoodListModel *foodListModel, NSError *error) {
        if (!error) {
            self.recommendFoodListModel = foodListModel;
            self.recommendFoodList = [foodListModel.data copy];
        }
        complete(error);
    }];
}

- (void)refreshFavoriteWithComplete:(void (^)(NSError *))complete {
    self.favoritesFoodList = [[CookData getAllObjects] copy];
    complete(nil);
}

- (NSInteger)locationHour {
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSInteger time = [locationString integerValue];
    return time;
}

- (NSString *)sceneCid {
    NSInteger time = [self locationHour];
    NSInteger cid = (time>=0)+(time>=10)+(time>=14)+(time>=16)+(time>=20)+36;
    return [NSString stringWithFormat:@"%ld",cid];
}

- (NSArray *)imageURLsFromFoodListModel:(FoodListModel *)foodListModel {
   
    return [self imageURLsFromFoodList:foodListModel.data];
}

- (NSArray *)imageURLsFromFoodList:(NSArray *)foodList {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (FoodModel *food in foodList) {
        NSString *URLString = food.albums.firstObject;
        [array addObject:[NSURL URLWithString:URLString]];
    }
    return [array copy];
}

- (NSArray *)titlesFromFoodListModel:(FoodListModel *)foodListModel {
    
    return [self titlesFromFoodList:foodListModel.data];
}

- (NSArray *)titlesFromFoodList:(NSArray *)foodList {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (FoodModel *food in foodList) {
        NSString *title = food.title;
        [array addObject:title];
    }
    return [array copy];
}
//场景食物图片
- (NSArray *)sceneImageURLs {
    
    return [self imageURLsFromFoodListModel:self.sceneFoodListModel];
}
//场景食物标题
- (NSArray *)sceneTitles {
    
    return [self titlesFromFoodListModel:self.sceneFoodListModel];
}
//推荐食物图片
- (NSArray *)recommendImageURLs {
    
    return [self imageURLsFromFoodListModel:self.recommendFoodListModel];
}
//推荐食物标题
- (NSArray *)recommendTitles {
    
    return [self titlesFromFoodListModel:self.recommendFoodListModel];
}
//收藏食物图片
- (NSArray *)favoritesImageURLs {
    
    return [self imageURLsFromFoodList:self.favoritesFoodList];
}
//收藏食物标题
- (NSArray *)favoritesTitles {
    
    return [self titlesFromFoodList:self.favoritesFoodList];
}

- (NSString *)scene {
    NSInteger time = [self locationHour];
    NSString *string;
    switch ((time>=0)+(time>=10)+(time>=14)+(time>=16)+(time>=20)) {
        case 1:
            string = @"早餐";
            break;
        case 2:
            string = @"午餐";
            break;
        case 3:
            string = @"下午茶";
            break;
        case 4:
            string = @"晚餐";
            break;
        case 5:
            string = @"夜宵";
            break;
        default:
            string = nil;
            break;
    }
    return string;
}


@end
