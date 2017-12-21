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
@property (weak, nonatomic) IBOutlet ZTTextField *noField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
    _textField.validationBlk = ^NSString *(ZTTextField *textField){
        if (_textField.text.length == 0) {
            return @"姓名不能为空";
        }
        return @"";
    };
    _noField.textFieldType = ZTTextFieldTypeNormal;
}
- (IBAction)didPressedDone:(id)sender {
    [_textField textFieldShowWrongMessage:@"姓名不能为空"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
