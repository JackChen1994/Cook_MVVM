//
//  MiniSearchView.m
//  Cook_MMVC
//
//  Created by tarena on 15/10/26.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MiniSearchView.h"
#import "ColorManger.h"

@interface MiniSearchView()<UITextFieldDelegate>

@end

@implementation MiniSearchView


- (void)awakeFromNib {
    
    [self initTextField];
    [self setColor];
}

- (void)setColor {
    self.backgroundColor = [UIColor clearColor];
    self.layer.shadowColor = [ColorManger primaryColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.5;
}

- (void)initTextField {
    CGRect frame = CGRectMake(10, (self.bounds.size.height-30)/2, self.bounds.size.width-20, 30);
    self.textField = [[UITextField alloc]initWithFrame:frame];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"搜索你想要的菜肴";
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.delegate = self;
    [self addSubview:self.textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.delegate didSearchWithText:textField.text];
    return YES;
}

@end
