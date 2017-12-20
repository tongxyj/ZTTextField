//
//  ZTTextField.m
//  ZTTextFieldText
//
//  Created by zhaitong on 2017/12/14.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

#import "ZTTextField.h"
@class LRTextField;

static CGFloat const placeholderLabelShowScale = 0.8978;
static CGFloat const placeholderLabelHideScale = 1.02;

@interface ZTTextField ()
@property (nonatomic) UILabel *placeholderLabel;
@property (nonatomic) UILabel *hintLabel;
@property (nonatomic, copy) NSString *sWrongFormatMsg;
@end

@implementation ZTTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}

- (void)updateUI {
    self.borderStyle = UITextBorderStyleNone;
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    [self createUpperPlaceholderLabel];
    [self createHintLabel];
   
    [self addTarget:self action:@selector(textFieldEdittingDidBeginInternal:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textFieldEdittingDidChangeInternal:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldEdittingDidEndInternal:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)setValidationBlk:(ValidationBlock)validationBlk {
    _validationBlk = validationBlk;
    if (validationBlk) {
        self.sWrongFormatMsg = self.validationBlk();
    }
}

- (void)createUpperPlaceholderLabel {
    self.placeholderLabel = [UILabel new];
    self.placeholderLabel.text = self.editingPhText;
    self.placeholderLabel.font = [UIFont systemFontOfSize:self.upperPhFontSize];//展示在👆的placeholder的字体大小
    [self.placeholderLabel sizeToFit];
    [self floatingLabelUpperColor];
    if (self.text.length > 0) {
        self.placeholderLabel.transform = CGAffineTransformMakeScale(placeholderLabelShowScale, placeholderLabelShowScale);//缩放
        self.placeholderLabel.frame = [self floatingLabelUpperFrame];
    } else {
        self.placeholderLabel.transform = CGAffineTransformMakeScale(placeholderLabelHideScale, placeholderLabelHideScale);//还原
        self.placeholderLabel.frame = self.textFieldType == ZTTextFieldTypeNormal ? [super textRectForBounds:self.bounds] : [self noBorderFloatingLabelFrame];
    }
    [self addSubview:self.placeholderLabel];
}

- (void)createHintLabel {
    self.hintLabel = [UILabel new];
    self.hintLabel.transform = CGAffineTransformMakeScale(placeholderLabelShowScale, placeholderLabelShowScale);//缩放
    self.hintLabel.font = [UIFont systemFontOfSize:self.hintLabelFontSize];
    self.hintLabel.textAlignment = NSTextAlignmentRight;
    self.hintLabel.textColor = self.placeholderInactiveColor;
    [self addSubview:self.hintLabel];
}



- (void)showBeginAnimation {
    [UIView transitionWithView:self.placeholderLabel
                      duration:0.35f
                       options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        self.placeholderLabel.text = self.upperPhText;
                        [self.placeholderLabel sizeToFit];
                        [self floatingLabelUpperColor];
                        self.placeholderLabel.transform = CGAffineTransformMakeScale(placeholderLabelShowScale, placeholderLabelShowScale);//缩放
                        self.placeholderLabel.frame = [self floatingLabelUpperFrame];
                    } completion:nil];
    [UIView transitionWithView:self.hintLabel
                      duration:0.35f
                       options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.hintLabel.alpha = 1;
                        self.hintLabel.text = self.hintLabelText;
                        [self.hintLabel sizeToFit];
                        self.hintLabel.textColor = self.placeholderInactiveColor;
                        [self hintLabelFrame];
                    } completion:nil];
 
}

- (void)showEndAnimation {
    [UIView transitionWithView:self.placeholderLabel
                      duration:0.35f
                       options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        self.placeholderLabel.text = self.editingPhText;
                        [self.placeholderLabel sizeToFit];
                        [self floatingLabelUpperColor];
                        self.placeholderLabel.transform = CGAffineTransformMakeScale(placeholderLabelHideScale, placeholderLabelHideScale);//还原
                        self.placeholderLabel.frame = self.textFieldType == ZTTextFieldTypeNormal ? [super textRectForBounds:self.bounds] : [self noBorderFloatingLabelFrame];
                    } completion:nil];
    
}

- (void)shakeHintLabel {
    self.hintLabel.alpha = 1;
    self.hintLabel.textColor = [UIColor redColor];
    self.hintLabel.text = self.sWrongFormatMsg;
    [self.hintLabel sizeToFit];
    [self hintLabelFrame];
    CABasicAnimation *animation = [CABasicAnimation animation];
    [animation setDuration:0.1];
    CGFloat x = CGRectGetMaxX(self.bounds) - self.hintLabel.frame.size.width - 5 + self.hintLabel.frame.size.width / 2;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(x  - 10, - 1 - self.frame.size.height / 2 + self.hintLabel.frame.size.height / 2)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(x  + 10, - 1 - self.frame.size.height / 2 + self.hintLabel.frame.size.height / 2)];
    animation.repeatCount = 3;
    animation.autoreverses = YES;
    [self.hintLabel.layer addAnimation:animation forKey:@"position"];
}

- (void)floatingLabelUpperColor {
    self.placeholderLabel.textColor = self.editing ? self.placeholderActiveColor : self.placeholderInactiveColor;
}
- (void)hintLabelFrame {
    CGRect placeHolderFrame = self.bounds;
    CGRect hintLabelFrame = self.hintLabel.frame;
    hintLabelFrame.origin.x = CGRectGetMaxX(placeHolderFrame) - self.hintLabel.frame.size.width - 5;
    hintLabelFrame.origin.y = - 1 - self.frame.size.height / 2;
    self.hintLabel.frame = hintLabelFrame;
}

- (CGRect)floatingLabelUpperFrame {
    CGRect placeHolderFrame = [super textRectForBounds:self.bounds];
    return CGRectMake(placeHolderFrame.origin.x - 1, - 1 - self.frame.size.height / 2, self.bounds.size.width - 2 * 0, self.frame.size.height / 2);
}

- (CGRect)noBorderFloatingLabelFrame {
    CGRect placeHolderFrame = [super textRectForBounds:self.bounds];
    //颜色置灰
    return CGRectMake(placeHolderFrame.origin.x - 1,0 , self.bounds.size.width - 2 * 0, self.frame.size.height / 2);
}

- (void)validateText {

    if (self.validationBlk) {
        self.sWrongFormatMsg = self.validationBlk();
    }
    if (self.sWrongFormatMsg.length > 0) {
        [UIView transitionWithView:self.hintLabel
                          duration:0.35f
                           options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.hintLabel.text = self.text.length > 0 ? self.sWrongFormatMsg : self.hintLabelText;
                            [self.hintLabel sizeToFit];
                            [self hintLabelFrame];
                            self.hintLabel.textColor = self.text.length > 0 ? [UIColor redColor] : _placeholderInactiveColor;
                            self.hintLabel.alpha = self.text.length > 0 ? 1 : 0;
                        } completion:nil];
    } else {
        [UIView transitionWithView:self.hintLabel
                          duration:0.35f
                           options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.hintLabel.alpha = 0;
                        } completion:nil];
    }
}

- (void)textFieldShowWrongFormatMessageIfNeed {
    if (self.sWrongFormatMsg.length > 0) {
        [self shakeHintLabel];
    }
}

#pragma mark - setter
- (void)setText:(NSString *)text {
    [super setText:text];
    if (text.length > 0) {
        [self showBeginAnimation];
    }
}

- (void)setTextFieldType:(ZTTextFieldType)textFieldType {
    _textFieldType = textFieldType;
    switch (textFieldType) {
        case ZTTextFieldTypeNoBorder:
            self.borderStyle = UITextBorderStyleNone;
            break;
        default:
            self.borderStyle = UITextBorderStyleRoundedRect;
            break;
    }
    self.placeholderLabel.frame = self.textFieldType == ZTTextFieldTypeNormal ? [super textRectForBounds:self.bounds] : [self noBorderFloatingLabelFrame];
}
#pragma mark - Target Method

- (IBAction)textFieldEdittingDidBeginInternal:(UITextField *)sender {
 //开始编辑
    [self runDidBeginAnimation];
}

- (IBAction)textFieldEdittingDidEndInternal:(UITextField *)sender {
    //验证文本规则
    [self validateText];
    //结束编辑
    [self runDidEndAnimation];
}
- (IBAction)textFieldEdittingDidChangeInternal:(UITextField *)sender {
    [self runDidChange];
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
                        } completion:nil];

    } else {
        
        [self showEndAnimation];
    }
}
/**< 正在编辑*/
- (void)runDidChange {
    if (self.text.length == 0) {
        
    }
}
@end
