//
//  ZTTextField.m
//  ZTTextFieldText
//
//  Created by zhaitong on 2017/12/14.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

#import "ZTTextField.h"

static CGFloat const placeholderLabelShowScale = 0.8978;
static CGFloat const placeholderLabelHideScale = 1.02;

@interface ZTTextField ()
@property (nonatomic) UILabel *placeholderLabel;
@property (nonatomic) UILabel *hintLabel;
@end

@implementation ZTTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}

- (void)updateUI {
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    [self createUpperPlaceholderLabel];
    [self createHintLabel];
   
    [self addTarget:self action:@selector(textFieldEdittingDidBeginInternal:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textFieldEdittingDidChangeInternal:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldEdittingDidEndInternal:) forControlEvents:UIControlEventEditingDidEnd];

   
}

- (void)createUpperPlaceholderLabel {
    self.placeholderLabel = [UILabel new];
    self.placeholderLabel.text = self.subPlText;
    self.placeholderLabel.font = [UIFont systemFontOfSize:self.subPhFontSize];//展示在👆的placeholder的字体大小
    [self floatingLabelUpperColor];
    if (self.text.length > 0) {
        self.placeholderLabel.transform = CGAffineTransformMakeScale(placeholderLabelShowScale, placeholderLabelShowScale);//缩放
        self.placeholderLabel.frame = [self floatingLabelUpperFrame];
    } else {
        self.placeholderLabel.transform = CGAffineTransformMakeScale(placeholderLabelHideScale, placeholderLabelHideScale);//还原
        self.placeholderLabel.frame = [super textRectForBounds:self.bounds];
    }
    [self addSubview:self.placeholderLabel];
}

- (void)createHintLabel {
    self.hintLabel = [UILabel new];
    self.hintLabel.text = self.hintLabelText;
    self.hintLabel.transform = CGAffineTransformMakeScale(placeholderLabelShowScale, placeholderLabelShowScale);//缩放
    self.hintLabel.font = [UIFont systemFontOfSize:self.hintLabelFontSize];
    [self.hintLabel sizeToFit];
    self.hintLabel.textAlignment = NSTextAlignmentRight;
    self.hintLabel.textColor = self.placeholderInactiveColor;
    [self hintLabelFrame];
    [self addSubview:self.hintLabel];
}

- (void)floatingLabelUpperColor {
    self.placeholderLabel.textColor = self.editing ? self.placeholderActiveColor : self.placeholderInactiveColor;
}
- (void)hintLabelFrame {
     CGRect placeHolderFrame = [super textRectForBounds:self.bounds];
    CGRect hintLabelFrame = self.hintLabel.frame;
    hintLabelFrame.origin.x = CGRectGetMaxX(placeHolderFrame) - self.hintLabel.frame.size.width;
    hintLabelFrame.origin.y = - 1 - self.frame.size.height / 2;
    self.hintLabel.frame = hintLabelFrame;
}

- (CGRect)floatingLabelUpperFrame {
    CGRect placeHolderFrame = [super textRectForBounds:self.bounds];
    //颜色置灰
    return CGRectMake(placeHolderFrame.origin.x - 1, - 1 - self.frame.size.height / 2, self.bounds.size.width - 2 * 0, self.frame.size.height / 2);
}

- (void)showBeginAnimation {
    [UIView transitionWithView:self.placeholderLabel
                      duration:0.35f
                       options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self floatingLabelUpperColor];
                        self.placeholderLabel.transform = CGAffineTransformMakeScale(placeholderLabelShowScale, placeholderLabelShowScale);//缩放
                        self.placeholderLabel.frame = [self floatingLabelUpperFrame];
                        self.hintLabel.alpha = 1;
                    } completion:nil];
}

- (void)showEndAnimation {
    [UIView transitionWithView:self.placeholderLabel
                      duration:0.35f
                       options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self floatingLabelUpperColor];
                        self.placeholderLabel.transform = CGAffineTransformMakeScale(placeholderLabelHideScale, placeholderLabelHideScale);//还原
                        self.placeholderLabel.frame = [super textRectForBounds:self.bounds];
                    } completion:nil];
}

#pragma mark - setter
- (void)setText:(NSString *)text {
    [super setText:text];
    if (text.length > 0) {
        [self showBeginAnimation];
    }
    
}

#pragma mark - Target Method

- (IBAction)textFieldEdittingDidBeginInternal:(UITextField *)sender {
 //开始编辑
    [self runDidBeginAnimation];
}

- (IBAction)textFieldEdittingDidEndInternal:(UITextField *)sender {
    //结束编辑
    [self runDidEndAnimation];
}

- (IBAction)textFieldEdittingDidChangeInternal:(UITextField *)sender {
 
}

/**
 * 开始编辑
 */
- (void)runDidBeginAnimation {
    
    if (self.text.length > 0 || self.editing) {//已经有内容
        [self showBeginAnimation];
    }
}

/**< 结束编辑*/
- (void)runDidEndAnimation {
    if (self.text.length > 0) {
        //执行动画
        [UIView transitionWithView:self.placeholderLabel
                          duration:0.3f
                           options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.placeholderLabel.textColor = self.placeholderInactiveColor;
                            self.hintLabel.alpha = 0;
                        } completion:nil];
    } else {
        
        [self showEndAnimation];
    }
}
/**< 正在编辑*/
- (void)runDidChange {
    
}
@end
