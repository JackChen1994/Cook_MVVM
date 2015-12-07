//
//  FavoritesViewModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "FavoritesViewModel.h"

@implementation FavoritesViewModel

- (void)getCacheFoodListCompleteWithError:(void (^)(NSError *))complete {
    self.foodList = [[CookData getAllObjects] copy];
    complete(nil);
}

- (void)deleteFoodAtIndex:(NSInteger )index {
    [CookData deleteDataAtIndex:index];
    [self getCacheFoodListCompleteWithError:^(NSError *error) {
    }];
}

- (NSString *)imageURLStringAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self foodModelAtIndexPath:indexPath].albums.firstObject;
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self foodModelAtIndexPath:indexPath].title;
}

- (FoodModel *)foodModelAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.foodList[indexPath.row];
}

- (NSString *)introAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self foodModelAtIndexPath:indexPath].imtro;
}
@end
