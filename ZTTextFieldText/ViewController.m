//
//  ViewController.m
//  ZTTextFieldText
//
//  Created by zhaitong on 2017/12/14.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

#import "ViewController.h"
#import "ZTTextField.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZTTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
    _textField.validationBlk = ^NSString *{
        if (_textField.text.length == 0) {
            return @"姓名不能为空";
        }
        return @"";
    };
}
- (IBAction)didPressedDone:(id)sender {
    [_textField textFieldShowWrongFormatMessageIfNeed];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
