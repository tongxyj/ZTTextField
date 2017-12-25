//
//  ViewController.swift
//  ZTTextField-Swift
//
//  Created by zhaitong on 2017/12/22.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldName: ZTTextField!
    @IBOutlet weak var textFieldMobile: ZTTextField!
    @IBOutlet weak var textFieldCertyNo: ZTTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldName.becomeFirstResponder()
        let closure = { (textField : ZTTextField) -> String in
            
            if let text = textField.text {
                guard text.count > 0 else {
                    return ""
                }
                return "姓名不能为空"
            }
            return ""
        }
        self.textFieldName.validationCloure = closure
        self.textFieldCertyNo.textFieldType = .ZTTextFieldTypeNormal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

