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

class ZTTextField: UITextField,CAAnimationDelegate {
    static let placeholderLabelShowScale : CGFloat = 0.8978
    static let placeholderLabelHideScale : CGFloat = 1.02
    
    @IBInspectable fileprivate var upperPhText : String? //Text to be displayed above the field.
    @IBInspectable fileprivate var editingPhText : String? //Text to be displayed in the field.
    @IBInspectable fileprivate var upperPhFontSize : CGFloat //FontSize of placeholder Label.
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
    @IBInspectable fileprivate var hintLabelFontSize : CGFloat
    /**
     * block vertify the text format
     */
    open var validationCloure : FormatValidationClosure? {
        
        willSet {
            if let tempValue = newValue {
                self.sWrongFormatMsg = tempValue(self)
            }
        }
    }
    /**
     * The type of the textfield
     */
    open var textFieldType : ZTTextFieldType = .ZTTextFieldTypeNoBorder{
        didSet {
            switch textFieldType {
            case .ZTTextFieldTypeNoBorder:
                self.borderStyle = UITextBorderStyle.none
            default:
                self.borderStyle = UITextBorderStyle.roundedRect
            }
            self.placeholderLabel?.frame = self.textFieldType == .ZTTextFieldTypeNormal ? super.textRect(forBounds: self.bounds) : self.noBorderFloatingLabelFrame()
        }
    }
    private var placeholderLabel : UILabel?
    private var hintLabel : UILabel?;
    private var sWrongFormatMsg : String?;
    
    override open var text: String? {
        didSet {
            super.text = text
            if let textCount = text?.count {
                if textCount > 0 {
                    self.showBeginAnimation()
                }
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        upperPhFontSize = 15
        hintLabelFontSize = 15
        super.init(coder: aDecoder)
        self.updateUI()
    }
    override init(frame: CGRect) {
        upperPhFontSize = 15
        hintLabelFontSize = 15
        super.init(frame: frame)
        self.updateUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
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
        self.placeholderLabel = UILabel.init()
        self.placeholderLabel?.text = self.editingPhText
        self.placeholderLabel?.font = UIFont.systemFont(ofSize: self.upperPhFontSize)
        self.placeholderLabel?.sizeToFit()
        self.floatingLabelUpperColor()
        if let textCount = self.text?.count {
            if textCount > 0 {
                self.placeholderLabel?.transform = CGAffineTransform(scaleX: ZTTextField.placeholderLabelShowScale, y: ZTTextField.placeholderLabelShowScale);//缩放
                self.placeholderLabel?.frame = self.floatingLabelUpperFrame()
            } else {
                self.placeholderLabel?.transform = CGAffineTransform(scaleX: ZTTextField.placeholderLabelHideScale, y: ZTTextField.placeholderLabelHideScale);//还原
                self.placeholderLabel?.frame = self.textFieldType == .ZTTextFieldTypeNormal ? super.textRect(forBounds: self.bounds) : self.noBorderFloatingLabelFrame()
            }
        }
        self.addSubview(self.placeholderLabel!)
    }
    func createHintLabel() {
        self.hintLabel = UILabel.init()
        self.hintLabel?.transform = CGAffineTransform(scaleX: ZTTextField.placeholderLabelShowScale, y: ZTTextField.placeholderLabelShowScale)//缩放
        self.hintLabel?.font = UIFont.systemFont(ofSize: self.hintLabelFontSize)
        self.hintLabel?.textAlignment = NSTextAlignment.right
        self.hintLabel?.textColor = self.placeholderInactiveColor
        self.addSubview(self.hintLabel!)
        
    }
    func floatingLabelUpperColor() {
        self.placeholderLabel?.textColor = self.isEditing ? self.placeholderActiveColor : self.placeholderInactiveColor
    }
    func showBeginAnimation() {
        UIView.transition(with: self.placeholderLabel!, duration: 0.35, options: [UIViewAnimationOptions.beginFromCurrentState,UIViewAnimationOptions.transitionFlipFromTop], animations: {
            self.placeholderLabel?.text = self.upperPhText
            self.placeholderLabel?.sizeToFit()
            self.floatingLabelUpperColor()
            self.placeholderLabel?.transform = CGAffineTransform(scaleX: ZTTextField.placeholderLabelShowScale, y: ZTTextField.placeholderLabelShowScale)//缩放
            self.placeholderLabel?.frame = self.floatingLabelUpperFrame()
        }, completion: nil)
        UIView.transition(with: self.hintLabel!, duration: 0.35, options: [UIViewAnimationOptions.beginFromCurrentState,UIViewAnimationOptions.transitionCrossDissolve], animations: {
            self.hintLabel?.alpha = 1;
            self.hintLabel?.text = self.hintLabelText;
            self.hintLabel?.sizeToFit()
            self.hintLabel?.textColor = self.placeholderInactiveColor
            self.hintLabelFrame()
        }, completion: nil)
    }
    func showEndAnimation() {
        UIView.transition(with: self.placeholderLabel!, duration: 0.35, options: [UIViewAnimationOptions.beginFromCurrentState,UIViewAnimationOptions.transitionFlipFromBottom], animations: {
            self.placeholderLabel?.text = self.editingPhText;
            self.placeholderLabel?.sizeToFit()
            self.floatingLabelUpperColor()
            self.placeholderLabel?.transform = CGAffineTransform(scaleX: ZTTextField.placeholderLabelHideScale, y: ZTTextField.placeholderLabelHideScale)//还原
            self.placeholderLabel?.frame = self.textFieldType == .ZTTextFieldTypeNormal ? super.textRect(forBounds: self.bounds) : self.noBorderFloatingLabelFrame()
        }, completion: nil)
    }
    func floatingLabelUpperFrame() -> CGRect {
        let placeHolderFrame : CGRect = super.textRect(forBounds: self.bounds)
        return CGRect(x: placeHolderFrame.origin.x - 1, y: -1 - self.frame.size.height / 2, width: self.bounds.size.width - 2, height: self.frame.size.height / 2)
    }
    func noBorderFloatingLabelFrame() -> CGRect {
        let placeHolderFrame : CGRect = super.textRect(forBounds: self.bounds)
        //颜色置灰
        return CGRect(x: placeHolderFrame.origin.x - 1, y: 0, width: self.bounds.size.width - 2, height: self.frame.size.height / 2)
    }
    func hintLabelFrame() {
        var hintLabelFrame :  CGRect = (self.hintLabel?.frame)!
        hintLabelFrame.origin.x = self.bounds.maxX - (self.hintLabel?.frame)!.size.width - 5
        hintLabelFrame.origin.y = -1 - self.frame.size.height / 2
        self.hintLabel?.frame = hintLabelFrame
    }
    func shakeHintLabel() {
        self.hintLabel?.alpha = 1
        self.hintLabel?.textColor = UIColor.red
        self.hintLabel?.text = self.sWrongFormatMsg
        self.hintLabel?.sizeToFit()
        self.hintLabelFrame()
        let animation = CABasicAnimation.init()
        animation.delegate = self
        animation.duration = 0.1
        let hintLabelX = self.bounds.maxX - (self.hintLabel?.frame.size.width)! - 5 + (self.hintLabel?.frame.size.width)! / 2
        animation.fromValue = NSValue.init(cgPoint: CGPoint.init(x: hintLabelX  - 10, y: -1 - self.frame.size.height / 2 + (self.hintLabel?.frame.size.height)! / 2))
        animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: hintLabelX  + 10, y: -1 - self.frame.size.height / 2 + (self.hintLabel?.frame.size.height)! / 2))
        animation.repeatCount = 3
        animation.autoreverses = true
        self.hintLabel?.layer.add(animation, forKey: "position")
    }
    func validateText() {
        if let validationCloure = self.validationCloure {
            self.sWrongFormatMsg = validationCloure(self)
        }
        if let wrongMsgCount = self.sWrongFormatMsg?.count {
            if wrongMsgCount > 0 {
                UIView.transition(with: self.hintLabel!, duration: 0.35, options: [UIViewAnimationOptions.beginFromCurrentState,UIViewAnimationOptions.transitionCrossDissolve], animations: {
                    if let textCount = self.text?.count {
                        self.hintLabel?.text = textCount > 0 ? self.sWrongFormatMsg : self.hintLabelText
                        self.hintLabel?.textColor = textCount > 0 ? UIColor.red : self.placeholderInactiveColor
                        self.hintLabel?.alpha = textCount  > 0 ? 1 : 0
                    }
                    self.hintLabel?.sizeToFit()
                    self.hintLabelFrame()
                }, completion: nil)
            }
        }
        UIView.transition(with: self.hintLabel!, duration: 0.35, options: [UIViewAnimationOptions.beginFromCurrentState,UIViewAnimationOptions.transitionCrossDissolve], animations: {
            self.hintLabel?.alpha = 0
        }, completion: nil)
    }
    
    @objc func textFieldEdittingDidBeginInternal() {
        //开始编辑
        self.runDidBeginAnimation()
    }
    @objc func textFieldEdittingDidChangeInternal() {
        
    }
    @objc func textFieldEdittingDidEndInternal() {
        //验证文本规则
        self.validateText()
        //结束编辑
        self.runDidEndAnimation()
    }
    /**< 开始编辑*/
    func runDidBeginAnimation() {
        if let textCount = self.text?.count {
            if textCount > 0 || self.isEditing {
                self.showBeginAnimation()
            }
        }
    }
    /**< 结束编辑*/
    func runDidEndAnimation() {
        if let textCount = self.text?.count {
            if textCount > 0 {
                UIView.transition(with: self.placeholderLabel!, duration: 0.35, options: [UIViewAnimationOptions.beginFromCurrentState,UIViewAnimationOptions.transitionFlipFromTop], animations: {
                    self.placeholderLabel?.textColor = self.placeholderInactiveColor
                }, completion: nil)
            }
            self.showEndAnimation()
        }
    }
    open func textFieldShowWrongMessage(sWrongMessage : String) {
        if let wrongMessageCount = sWrongFormatMsg?.count {
            if wrongMessageCount > 0 {
                self.shakeHintLabel()
            }
        }
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        UIView.transition(with: self.hintLabel!, duration: 1.5, options: [UIViewAnimationOptions.beginFromCurrentState,UIViewAnimationOptions.transitionCrossDissolve], animations: {
            self.hintLabel?.alpha = 0;
        }, completion: nil)
    }
    
}
