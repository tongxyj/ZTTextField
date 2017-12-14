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
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    self.placeholderLabel = [UILabel new];
    self.placeholderLabel.text = @"测试";
    self.placeholderLabel.frame = [super textRectForBounds:self.bounds];
    self.placeholderLabel.font = [UIFont systemFontOfSize:self.subPhFontSize];//展示在👆的placeholder的字体大小
    [self addTarget:self action:@selector(textFieldEdittingDidBeginInternal:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textFieldEdittingDidChangeInternal:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldEdittingDidEndInternal:) forControlEvents:UIControlEventEditingDidEnd];
    [self addSubview:self.placeholderLabel];
   
}

- (CGRect) floatingLabelUpperFrame {
    //颜色置灰
    self.placeholderLabel.textColor = self.placeholderInactiveColor;
    return CGRectMake(0, -30, 100, 30);
}

#pragma mark - setter
- (void)setText:(NSString *)text {
    [super setText:text];
    
}

#pragma mark - Target Method

- (IBAction) textFieldEdittingDidBeginInternal:(UITextField *)sender {
 //开始编辑
    [self runDidBeginAnimation];
}

- (IBAction) textFieldEdittingDidEndInternal:(UITextField *)sender {
    //结束编辑
    [self runDidEndAnimation];
}

- (IBAction) textFieldEdittingDidChangeInternal:(UITextField *)sender {
 
}

/**
 * 开始编辑
 */
- (void) runDidBeginAnimation {
    
    if (self.text.length > 0 || self.editing) {//已经有内容
        //需要把subplaceholder展示在textField上边
        //        self.placeholderLabel.transform = CGAffineTransformMakeScale(0, 0);
        self.placeholderLabel.frame = [self floatingLabelUpperFrame];
    } else {
        //Label shown the same as placeholder
        self.placeholderLabel.textColor = self.placeholderActiveColor;
        //        self.placeholderLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.placeholderLabel.frame = [super textRectForBounds:self.bounds];
    }
}

/**< 结束编辑*/
- (void) runDidEndAnimation {
    if (self.text.length > 0) {//如果有内容则让placeholder保持在field上边
        self.placeholderLabel.frame = [self floatingLabelUpperFrame];
    } else {
        self.placeholderLabel.textColor = self.placeholderActiveColor;
        self.placeholderLabel.frame = [super textRectForBounds:self.bounds];
    }
}
/**< 正在编辑*/
- (void) runDidChange {
    
}
@end
