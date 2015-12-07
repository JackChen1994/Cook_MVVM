//
//  BaseModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseModelDelegate <NSObject>

+ (id)parse:(id)responseObj;

@end

@interface BaseModel : NSObject<BaseModelDelegate>

@property (nonatomic, strong) NSNumber *error_code;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *resultCode;

@end
