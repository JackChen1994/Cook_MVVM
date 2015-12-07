//
//  SubCategoryViewModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "SubCategoryViewModel.h"

@implementation SubCategoryViewModel

- (SubCategoryModel *) subCategoryAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.subCategoryList.subCategories[indexPath.row];
}

- (NSString *) nameAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self subCategoryAtIndexPath:indexPath].name;
}

- (NSString *) idAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self subCategoryAtIndexPath:indexPath].id;
}

@end
