//
//  ZTTextField.h
//  ZTTextFieldText
//
//  Created by zhaitong on 2017/12/14.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NSString *(^ValidationBlock)(void);

IB_DESIGNABLE
@interface ZTTextField : UITextField
/**
 * Text to be displayed above the field.
 */
@property (nonatomic, copy) IBInspectable NSString* subPlText;
/**
 * FontSize of placeholder Label.
 */
@property (nonatomic, assign) IBInspectable CGFloat subPhFontSize;
/**
 * Text color to be applied to floating placeholder text when not editing.
 * Default is 70% gray.
 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderInactiveColor;
/**
 * Text color to be applied to floating placeholder text when editing.
 * Default is tint color.
 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderActiveColor;
/**
 * Hint label text.
 */
@property (nonatomic, copy) IBInspectable NSString* hintLabelText;
/**
 * FontSize of hint Label.
 */
@property (nonatomic, assign) IBInspectable CGFloat hintLabelFontSize;
/**
 * block vertify the text format
 */
@property (nonatomic, copy) ValidationBlock validationBlk;
/**
 * if the text format is wrong
 */
@property (nonatomic, assign) BOOL bWrongFormat;

- (void)textFieldShowWrongFormatMessageIfNeed;
@end
