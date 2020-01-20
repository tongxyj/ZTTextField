//
//  ViewController.m
//  ZTTextFieldText
//
//  Created by zhaitong on 2017/12/14.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

#import "ViewController.h"
#import "ZTTextFieldText-Swift.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZTTextField *textField;
@property (weak, nonatomic) IBOutlet ZTTextField *noField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField becomeFirstResponder];

    _textField.validationCloure = ^NSString * _Nonnull(ZTTextField * _Nonnull textField) {
        if (textField.text.length > 0) {
            return @"姓名不能为空";
        }
        return @"";
    };
}
- (IBAction)didPressedDone:(id)sender {

    [self.textField textFieldShowWrongMessageWithSWrongMessage:@"姓名不能为空"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
