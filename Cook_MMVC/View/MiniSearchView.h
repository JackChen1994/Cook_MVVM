//
//  MiniSearchView.h
//  Cook_MMVC
//
//  Created by tarena on 15/10/26.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MiniSearchDelegate <NSObject>

@required
- (void)didSearchWithText:(NSString *)text;

@end

@interface MiniSearchView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) id<MiniSearchDelegate> delegate;

@end
