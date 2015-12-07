//
//  MainCategoryViewModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MainCategoryViewModel.h"
#import "CookData.h"
#import "CategoryListModel.h"
#import "SubCategoryViewModel.h"

@implementation MainCategoryViewModel

- (CategoryListModel *)categoryList {
    if (!_categoryList) {
        [self getCategoryListCompleteWithError:^(NSError *error) {
        }];
    }
    return _categoryList;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath {

    return [self subCategoryListModelAtIndexPath:indexPath].name;
}

- (NSInteger)numberOfSubCategoryListAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self subCategoryListModelAtIndexPath:indexPath].subCategories.count;
}

- (SubCategoryListModel *)subCategoryListModelAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.categoryList.categories[indexPath.row];
}

- (id)getCategoryListCompleteWithError:(void(^)(NSError *error))complete {
    NSArray *arr = [CookData getCategoryListData];
    CategoryListModel *categoryList = [CategoryListModel parse:arr];
    _categoryList = categoryList;
    complete(nil);
    return categoryList;
}

- (SubCategoryViewModel *)subCategoryAtIndexPath:(NSIndexPath *)indexPath {
    
    SubCategoryViewModel *subCategoryVM = [[SubCategoryViewModel alloc]init];
    subCategoryVM.subCategoryList = [self subCategoryListModelAtIndexPath:indexPath];
    return subCategoryVM;
}

@end


