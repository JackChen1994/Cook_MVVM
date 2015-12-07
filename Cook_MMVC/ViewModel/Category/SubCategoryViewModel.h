//
//  SubCategoryViewModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "CategoryListModel.h"

@interface SubCategoryViewModel : BaseViewModel

@property (nonatomic, strong) SubCategoryListModel *subCategoryList;

- (NSString *) nameAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *) idAtIndexPath:(NSIndexPath *)indexPath;

@end
