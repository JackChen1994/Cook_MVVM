//
//  DetailHeaderView.m
//  Cook_MMVC
//
//  Created by tarena on 15/11/2.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "DetailHeaderView.h"
#import "ColorManger.h"

@interface DetailHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation DetailHeaderView
typedef void (^ActionBlock)();
static char overviewKey;

- (void)awakeFromNib {
    
    [self initColor];
}

- (void)initColor {
    
    //背景
    self.backgroundColor = [ColorManger primaryColor];
    //描述
    self.headLabelView.textColor = [ColorManger lightPrimaryColor];
    //添加阴影
    CALayer *headLayer = [self layer];
    headLayer.shadowColor = [ColorManger dividerColor].CGColor;
    headLayer.shadowOffset = CGSizeMake(4, 4);
    headLayer.shadowOpacity = 0.5;
    headLayer.shadowRadius = 2;
    //图片
    CALayer *imageLayer = [self.headImageView layer];
    imageLayer.borderColor = [ColorManger lightPrimaryColor].CGColor;
    imageLayer.borderWidth = 5.0f;
}

- (IBAction)clickButton:(id)sender {
    
    [self.delegate clickButton];
}

- (void)setButtonSelected:(BOOL)isSelected {
    
    self.button.selected = isSelected;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.button reloadInputViews];
    });
}

- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(void (^)(void))block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.button addTarget:self action:@selector(callActionBlock:) forControlEvents:controlEvent];
}

- (void)callActionBlock:(id)sender {
    void(^block)() = (void (^)(void))objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}

- (BOOL)isButtonSelected {
    
    return self.button.isSelected;
}
@end
