//
//  CookData.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CookData.h"

@interface CookData()

@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) NSString *cooksPath;
@property (nonatomic, strong) NSString *dataPath;

@end

@implementation CookData

+ (id)getCategoryListData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cook" ofType:@"plist"];
    NSArray *categoryListData = [NSArray arrayWithContentsOfFile:filePath];
    
    return categoryListData;
}

- (NSString *)dataPath {
    if (!_dataPath) {
        _dataPath =  [self.cooksPath stringByAppendingPathComponent:@"cook.plist"];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:_dataPath]) {
        [[NSFileManager defaultManager] createFileAtPath:_dataPath contents:nil attributes:nil];
    }
    return _dataPath;
}


- (NSString *)cooksPath {
    if (!_cooksPath) {
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _cooksPath = [documentPath stringByAppendingPathComponent:@"cooks"];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:_cooksPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:_cooksPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return _cooksPath;
}

- (NSMutableArray *)mArray {
    
    _mArray = [NSMutableArray arrayWithContentsOfFile:self.dataPath];
    return _mArray;
}

+ (NSArray *)getAllObjects {
    return [[[CookData alloc]init] getAllObjects];
}

- (NSArray *)getAllObjects {
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.mArray) {
        FoodModel *foodModel = [FoodModel parse:dic];
        [mutableArray addObject:foodModel];
    }
    return [mutableArray copy];
}


- (void)saveData {
    NSLog(@"%@",self.dataPath);
    [_mArray writeToFile:self.dataPath atomically:YES];
}

+ (BOOL)isCachedWithObject:(id)object {
    
    return [[[CookData alloc]init] isCachedWithObject:object];
}

- (BOOL)isCachedWithObject:(id)object {
    
    return [self.mArray containsObject:object];
}

+ (void)cachesDataWithObject:(id)object {
    
    [[[CookData alloc]init] cachesDataWithObject:object];
}

- (void)cachesDataWithObject:(id)object {
    
    if ([self.mArray containsObject:object]) {
        return;
    }
    if (!_mArray) {
        _mArray = [[NSMutableArray alloc]init];
    }
    [_mArray addObject:object];
    [self saveData];
}

+ (void)deleteDataAtIndex:(NSInteger )index {
    
    [[[CookData alloc]init] deleteDataAtIndex:index];
}

- (void)deleteDataAtIndex:(NSInteger)index {
    
    if (self.mArray.count < index) {
        NSLog(@"index no found");
    }else {
        [self.mArray removeObjectAtIndex:index];
        [self saveData];
    }
}



+ (void)deleteDataWithObject:(id)object {
    
    [[[CookData alloc]init] deleteDataWithObject:object];
}

- (void)deleteDataWithObject:(id)object {
    
    if ([self isCachedWithObject:object]) {
        [self.mArray removeObject:object];
        [self saveData];
    }
}

@end
