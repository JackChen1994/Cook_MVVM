//
//  FoodListModel.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseModel.h"

//食物列表
@interface FoodListModel : BaseModel

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *totalName;
@property (nonatomic, strong) NSString *pn;
@property (nonatomic, strong) NSString *rn;

@end

//食物模型
@interface FoodModel : BaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *imtro;
@property (nonatomic, strong) NSString *ingredients;
@property (nonatomic, strong) NSString *burden;
@property (nonatomic, strong) NSArray *albums;
@property (nonatomic, strong) NSArray *steps;
@property (nonatomic, strong) NSDictionary *foodDictionary;

@end

//烹饪步骤
@interface stepModel : BaseModel

@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *step;

@end