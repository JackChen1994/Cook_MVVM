//
//  DetailViewModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel

- (instancetype)initWithFoodModel:(FoodModel *)foodModel {
    self = [super init];
    if (self) {
        self.foodModel = foodModel;
    }
    return self;
}

- (NSString *)imageURLString {
    
    return self.foodModel.albums.firstObject;
}

- (NSString *)title {
    
    return self.foodModel.title;
}

- (NSString *)intro {
    
    return self.foodModel.imtro;
}

- (stepModel *)stepModelAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.foodModel.steps[indexPath.row];
}

- (NSString *)stepImageAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self stepModelAtIndexPath:indexPath].img;
}
- (NSString *)stepTitleAtIndexPath:(NSIndexPath *)indexPath; {
    
    return [self stepModelAtIndexPath:indexPath].step;
}

- (NSArray *)ingredients {
    
    return [self.foodModel.ingredients componentsSeparatedByString:@";"];
}
- (NSInteger)countOfIngredients {
    
    return [self ingredients].count;
}
- (NSString *)ingredientAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self ingredients][indexPath.row];
}

- (NSArray *)burden {
    
    return [self.foodModel.burden componentsSeparatedByString:@";"];
}
- (NSInteger)countOfBurden {
    
    return [self burden].count;
}
- (NSString *)burdenAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self burden][indexPath.row];
}


#pragma mark - 缓存
- (BOOL)isCached {
    
    return [CookData isCachedWithObject:self.foodModel.foodDictionary];
}

- (void)cache {
    
    [CookData cachesDataWithObject:self.foodModel.foodDictionary];
}

- (void)deCache {
    
    [CookData deleteDataWithObject:self.foodModel.foodDictionary];
}

@end
