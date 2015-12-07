//
//  BaseNetwork.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseNetwork.h"
#import <UIKit/UIKit.h>

@implementation BaseNetwork

+ (id)Get:(NSString *)path parameters:(NSDictionary *)params completeHandle:(void (^)(id, NSError *))complete {
    //拼接请求字符串 服务器地址?值=value&值=value...
    NSMutableString *requestPath = [NSMutableString new];
    [requestPath appendString:path];
    [requestPath appendString:@"?"];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"%@=%@&", key, obj];
        [requestPath appendString:str];
    }];
    NSLog(@"%@",requestPath);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:requestPath] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            complete(nil, error);
        }else {
            NSError *error1 = nil;
            id responseObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:&error1];
            if (error1) {
                complete(nil, error1);
            }else {
                NSInteger errorCode = [responseObj[@"error_code"] integerValue];
                if(errorCode){
                    complete(nil, [NSError errorWithDomain:@"returnError" code:errorCode userInfo:responseObj[@"reason"]]);
                }else {
                    complete(responseObj, nil);
                }
            }
        }
    }];
    [task resume];
    return task;
}

@end
