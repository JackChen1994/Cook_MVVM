//
//  DetailHeaderView.h
//  Cook_MMVC
//
//  Created by tarena on 15/11/2.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@protocol DetailHeadViewDelegate <NSObject>

@required
- (void)clickButton;

@end

@interface DetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *headLabelView;
@property (nonatomic, strong)id<DetailHeadViewDelegate> delegate;

- (void)setButtonSelected:(BOOL)isSelected;

- (BOOL)isButtonSelected;

- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(void (^)(void))block;

@end
