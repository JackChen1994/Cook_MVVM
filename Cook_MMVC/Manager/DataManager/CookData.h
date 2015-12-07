//
//  CookData.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseData.h"
#import "FoodListModel.h"

@interface CookData : BaseData

+ (id)getCategoryListData;                          
//判断时候已经缓存
+ (BOOL)isCachedWithObject:(id)object;
//存
+ (void)cachesDataWithObject:(id)object;
//取
+ (NSArray *)getAllObjects;
//删
+ (void)deleteDataAtIndex:(NSInteger )index;
+ (void)deleteDataWithObject:(id)object;
@end
