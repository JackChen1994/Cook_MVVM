//
//  MainViewModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/11/30.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "FoodListModel.h"

@interface MainViewModel : BaseViewModel

@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, strong) FoodListModel *foodListModel;
@property (nonatomic, strong) NSMutableArray *foodList;

@property (nonatomic, strong) NSURLSessionTask *sceneTask;
@property (nonatomic, strong) FoodListModel *sceneFoodListModel;
@property (nonatomic, strong) NSMutableArray *sceneFoodList;

@property (nonatomic, strong) NSURLSessionTask *recommendTask;
@property (nonatomic, strong) FoodListModel *recommendFoodListModel;
@property (nonatomic, strong) NSMutableArray *recommendFoodList;

@property (nonatomic, strong) FoodListModel *favoritesFoodListModel;
@property (nonatomic, strong) NSMutableArray *favoritesFoodList;


- (NSArray *)imageURLs;
//开始加载数据
- (void)refreshHeadWithComplete:(void (^)(NSError *error))complete;
- (void)refreshSceneWithComplete:(void (^)(NSError *error))complete;
- (void)refreshRecommendWithComplete:(void (^)(NSError *error))complete;
- (void)refreshFavoriteWithComplete:(void (^)(NSError *error))complete;
//时间场景
- (NSString *)scene;
//场景食物图片
- (NSArray *)sceneImageURLs;
//场景食物标题
- (NSArray *)sceneTitles;
//推荐食物图片
- (NSArray *)recommendImageURLs;
//推荐食物标题
- (NSArray *)recommendTitles;
//收藏食物图片
- (NSArray *)favoritesImageURLs;
//收藏食物标题
- (NSArray *)favoritesTitles;

- (NSString *)sceneCid;

@end
