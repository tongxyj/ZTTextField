//
//  ZTTextField.swift
//  ZTTextField-Swift
//
//  Created by zhaitong on 2017/12/22.
//  Copyright © 2017年 zhaitong. All rights reserved.
//

import UIKit

enum ZTTextFieldType {
    case ZTTextFieldTypeNoBorder
    case ZTTextFieldTypeNormal
}

typealias FormatValidationClosure = (_ textField : ZTTextField) -> String

@IBDesignable

class ZTTextField: UITextField {
   
    @IBInspectable fileprivate var upperPhText : String? //Text to be displayed above the field.
    @IBInspectable fileprivate var editingPhText : String? //Text to be displayed in the field.
    @IBInspectable fileprivate var upperPhFontSize : Float //FontSize of placeholder Label.
    @IBInspectable fileprivate var placeholderInactiveColor : UIColor? //Text color to be applied to floating placeholder text when editing.
    /**
     * Text color to be applied to floating placeholder text when editing.
     * Default is tint color.
     */
    @IBInspectable fileprivate var placeholderActiveColor : UIColor?
    /**
     * Hint label text.
     */
    @IBInspectable fileprivate var hintLabelText : String?
    /**
     * FontSize of hint Label.
     */
    @IBInspectable fileprivate var hintLabelFontSize : Float
    /**
     * block vertify the text format
     */
    fileprivate var validationCloure : FormatValidationClosure? {
        willSet {
            
            self.sWrongFormatMsg =  newValue!(self)
        }
    }
    /**
     * The type of the textfield
     */
    fileprivate var textFieldType : ZTTextFieldType
    
    private var placeholderLabel : UILabel?
    private var hintLabel : UILabel?;
    private var sWrongFormatMsg : String?;
    
    required public init?(coder aDecoder: NSCoder) {
        upperPhFontSize = 15
        hintLabelFontSize = 15
        textFieldType = .ZTTextFieldTypeNormal
        super.init(coder: aDecoder)
        self.updateUI()
    }
    
    fileprivate final func updateUI() {
        borderStyle = .none
        clipsToBounds = false;
        backgroundColor = UIColor.clear
    
        self.createUpperPlaceholderLabel()
        self.createHintLabel()
        self.addTarget(self, action: #selector(self.textFieldEdittingDidBeginInternal), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.textFieldEdittingDidChangeInternal), for: .editingChanged)
        self.addTarget(self, action: #selector(self.textFieldEdittingDidEndInternal), for: .editingDidEnd)
    }
    func createUpperPlaceholderLabel() {
        
    }
    func createHintLabel() {
        
    }
    @objc func textFieldEdittingDidBeginInternal() {
        
    }
    @objc func textFieldEdittingDidChangeInternal() {
        
    }
    @objc func textFieldEdittingDidEndInternal() {
        
    }
    
}
