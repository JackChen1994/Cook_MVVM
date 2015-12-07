//
//  BaseModel.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    
}

+ (id)parse:(id)responseObj {
    id obj = [self new];
    [obj setValuesForKeysWithDictionary:responseObj];
    return obj;
}

@end
