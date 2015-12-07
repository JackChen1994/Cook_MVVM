//
//  FoodListViewModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "FoodListModel.h"

@interface FoodListViewModel : BaseViewModel

@property (nonatomic, strong) NSURLSessionDataTask *task;

@property (nonatomic, strong) FoodListModel *foodListModel;

@property (nonatomic, strong) NSMutableArray *foodList;
@property (nonatomic, assign) BOOL searchModel;
@property (nonatomic, strong) NSString *searchText;

@property (nonatomic, strong) NSString *cid;
@property (nonatomic, assign) NSInteger beginIndex;
@property (nonatomic, assign) NSInteger nextIndex;

- (id)initWithCid:(NSString *)cid;
- (id)initWithSearchText:(NSString *)text;

- (void)refreshFoodListCompleteWithError:(void(^)(NSError *error))complete;

- (void)getMoreFoodListCompleteWithError:(void(^)(NSError *error))complete;

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)imageUrlStringAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)introAtIndexPath:(NSIndexPath *)indexPath;

- (FoodModel *)foodModelAtIndexPath:(NSIndexPath *)indexPath;

- (void)searchWithText:(NSString *)text completeWithError:(void (^)(NSError *error))complete;

@end
