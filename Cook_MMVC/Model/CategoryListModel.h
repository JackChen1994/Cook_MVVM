//
//  CategoryListModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseModel.h"

//主分类列表
@interface CategoryListModel : BaseModel

@property (nonatomic, strong) NSArray *categories;

@end

//子分类列表
@interface SubCategoryListModel : BaseModel

@property (nonatomic, strong) NSArray *subCategories;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *parentId;

@end

//子分类模型
@interface SubCategoryModel : BaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *parentId;

@end