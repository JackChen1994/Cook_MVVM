//
//  MainCategoryViewModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "CategoryListModel.h"
#import "SubCategoryViewModel.h"

@interface MainCategoryViewModel : BaseViewModel

@property (nonatomic, strong) CategoryListModel *categoryList;

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSubCategoryListAtIndexPath:(NSIndexPath *)indexPath;

- (id)getCategoryListCompleteWithError:(void(^)(NSError *error))complete;

- (SubCategoryViewModel *)subCategoryAtIndexPath:(NSIndexPath *)indexPath;
@end
