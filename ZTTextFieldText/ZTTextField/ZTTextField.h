//
//  ZTTextField.h
//  ZTTextFieldText
//
//  Created by zhaitong on 2017/12/14.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface ZTTextField : UITextField
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
@end
