//
//  CategoryListModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CategoryListModel.h"

@implementation CategoryListModel

+(id)parse:(NSArray *)responseObj {
    CategoryListModel *model = [[CategoryListModel alloc]init];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dic in responseObj) {
        [arr addObject:[SubCategoryListModel parse:dic]];
    }
    model.categories = [arr copy];
    return model;
}

@end


@implementation SubCategoryListModel

+ (id)parse:(NSDictionary *)responseObj {
    SubCategoryListModel *model = [[SubCategoryListModel alloc]init];
    [model setValuesForKeysWithDictionary:responseObj];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dic in responseObj[@"list"]) {
        [arr addObject:[SubCategoryModel parse:dic]];
    }
    model.subCategories = [arr copy];
    return model;
}

@end


@implementation SubCategoryModel


@end