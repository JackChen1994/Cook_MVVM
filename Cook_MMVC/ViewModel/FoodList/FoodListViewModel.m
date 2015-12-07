//
//  FoodListViewModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "FoodListViewModel.h"
#import "CookNetwork.h"

@implementation FoodListViewModel

- (NSMutableArray *)foodList {
    if (!_foodList) {
        _foodList = [[NSMutableArray alloc]init];
    }
    return _foodList;
}

- (void)setFoodListModel:(FoodListModel *)foodListModel {
    _foodListModel = foodListModel;
    if ([foodListModel.pn integerValue] == 0) {
        [_foodList removeAllObjects];
    }
    [self.foodList addObjectsFromArray:foodListModel.data];
    _nextIndex = [foodListModel.pn integerValue] + [foodListModel.rn integerValue];
}

- (void)cancelNetWork {
    [_task cancel];
}

- (id)initWithCid:(NSString *)cid {
    if (self = [super init]) {
        _cid = cid;
    }
    return self;
}

- (id)initWithSearchText:(NSString *)text {
    if (self = [super init]) {
        _searchModel = YES;
        _searchText = text;
    }
    return self;
}

- (void)refreshFoodListCompleteWithError:(void (^)(NSError *))complete {
    if (!self.searchModel) {
        _beginIndex = 0;
        [self getFoodListFromNetwork:complete];
    }else {
        _beginIndex = 0;
        [self searchWithNetworkCompleteWithError:complete];
    }
}

- (void)getMoreFoodListCompleteWithError:(void (^)(NSError *))complete {
    if (!self.searchModel) {
        _beginIndex = self.nextIndex;
        [self getFoodListFromNetwork:complete];
    }else {
        _beginIndex = self.nextIndex;
        [self searchWithNetworkCompleteWithError:complete];
    }
}

- (void)getFoodListFromNetwork:(void(^)(NSError *))complete {
    if (!_cid) {
        return;
    }
    
    [_task cancel];
    _task = [CookNetwork getFoodListWithIndex:_beginIndex categoryId:_cid Complete:^(FoodListModel *foodListModel, NSError *error) {
        if (!error) {
            self.foodListModel = foodListModel;
        }
        complete(error);
    }];
}

- (FoodModel *)foodModelAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.foodList[indexPath.row];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self foodModelAtIndexPath:indexPath].title;
}

- (NSString *)imageUrlStringAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self foodModelAtIndexPath:indexPath].albums.firstObject;
}

- (NSString *)introAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self foodModelAtIndexPath:indexPath].imtro;
}

- (void)searchWithText:(NSString *)text completeWithError:(void (^)(NSError *))complete{
    self.searchModel = YES;
    self.searchText = text;
    self.beginIndex = 0;
    [self searchWithNetworkCompleteWithError:complete];
}

- (void)searchWithNetworkCompleteWithError:(void (^)(NSError *))complete {
    if(!self.searchText){
        return;
    }

    _task = [CookNetwork searchFoodWithIndex:_beginIndex foodName:[_searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Complete:^(FoodListModel *foodListModel, NSError *error) {
        if (!error) {
            self.foodListModel = foodListModel;
        }
        complete(error);
    }];
}

@end
