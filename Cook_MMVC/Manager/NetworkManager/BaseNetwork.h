//
//  BaseNetwork.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetwork : NSObject

+ (id)Get:(NSString *)path parameters:(NSDictionary *)params completeHandle:(void(^)(id responseObj, NSError *error))complete;

@end
