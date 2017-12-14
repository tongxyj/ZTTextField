//
//  ZTTextField.m
//  ZTTextFieldText
//
//  Created by zhaitong on 2017/12/14.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

#import "ZTTextField.h"
@interface ZTTextField ()
@property (nonatomic) UILabel *placeholderLabel;
@end

@implementation ZTTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}

- (void)updateUI {
    self.placeholderLabel = [UILabel new];
    self.placeholderLabel.font = [UIFont systemFontOfSize:self.subPhFontSize];//展示在👆的placeholder的字体大小
    [self addTarget:self action:@selector(textFieldEdittingDidBeginInternal:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textFieldEdittingDidChangeInternal:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldEdittingDidEndInternal:) forControlEvents:UIControlEventEditingDidEnd];
    [self addSubview:self.placeholderLabel];
   
}

/**
 * 开始编辑
 */
- (void) runDidBeginAnimation {

    if (self.text.length > 0) {//已经有内容
        
    }
}

#pragma mark - Target Method

- (IBAction) textFieldEdittingDidBeginInternal:(UITextField *)sender {
 //开始编辑
    [self runDidBeginAnimation];
}

- (IBAction) textFieldEdittingDidEndInternal:(UITextField *)sender {
  
}

- (IBAction) textFieldEdittingDidChangeInternal:(UITextField *)sender {
 
}
@end
