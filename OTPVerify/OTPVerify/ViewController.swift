//
//  ViewController.swift
//  OTPVerify
//
//  Created by Kirameki on 1/12/2562 BE.
//  Copyright © 2562 ngunngun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var enterOPTLabel: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var resendUnderlineView: UIView!
    @IBOutlet weak var resendButtonStackView: UIStackView!
    
    @IBOutlet weak var resendLabel: UILabel!
    @IBOutlet weak var resendLabelUnderlineView: UIView!
    @IBOutlet weak var resendLabelStackView: UIStackView!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var firstUnderline: UIView!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var secondUnderline: UIView!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var thirdUnderline: UIView!
    @IBOutlet weak var forthTextField: UITextField!
    @IBOutlet weak var forthUnderline: UIView!
    @IBOutlet weak var fifthTextField: UITextField!
    @IBOutlet weak var fifthUnderline: UIView!
    @IBOutlet weak var sixthTextField: UITextField!
    @IBOutlet weak var sixthUnderline: UIView!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var centerPoint: CGPoint!
    var email = ""
    var error = ""
    
    var countdownTimer: Timer!
    let totalTime = 60
    var remainTime = 60
    var startTime = Date()
    
    var otpText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.setUpUIColor()
        self.setUpData()
        self.setUpTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.centerPoint = self.view.center
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    func setUpTextField() {
        self.firstTextField.delegate = self
        self.secondTextField.delegate = self
        self.thirdTextField.delegate = self
        self.forthTextField.delegate = self
        self.fifthTextField.delegate = self
        self.sixthTextField.delegate = self
        
        self.firstTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.secondTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.thirdTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.forthTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.fifthTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.sixthTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    @IBAction func otpButtonPressed(_ sender: UIButton) {
        self.otpText = self.otpText.replace(" ", withString: "")
        if self.otpText.count == 0 {
            firstTextField.becomeFirstResponder()
        } else if self.otpText.count == 1 {
            firstTextField.becomeFirstResponder()
        } else if self.otpText.count == 2 {
            secondTextField.becomeFirstResponder()
        } else if self.otpText.count == 3 {
            thirdTextField.becomeFirstResponder()
        } else if self.otpText.count == 4 {
            forthTextField.becomeFirstResponder()
        } else if self.otpText.count == 5 {
            fifthTextField.becomeFirstResponder()
        } else {
            sixthTextField.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if let text = textField.text {
            if text.count == 1 {
                self.otpText = self.otpText + text
                
            } else if text.count == 0 {
                self.verificationUIColor(isSuccess: true)
                switch textField {
                    case firstTextField:
                        self.otpText = ""
                        firstTextField.becomeFirstResponder()
                    case secondTextField:
                        self.otpText.removeLast()
                        firstTextField.becomeFirstResponder()
                    case thirdTextField:
                        self.otpText.removeLast()
                        secondTextField.becomeFirstResponder()
                    case forthTextField:
                        self.otpText.removeLast()
                        thirdTextField.becomeFirstResponder()
                    case fifthTextField:
                        self.otpText.removeLast()
                        forthTextField.becomeFirstResponder()
                    case sixthTextField:
                        self.otpText.removeLast()
                        fifthTextField.becomeFirstResponder()
                    default:
                        break
                }
            } else if text.count == 2 {
                self.otpText = self.otpText + String(text.suffix(text.count - 1))
                switch textField {
                    case firstTextField:
                        secondTextField.text = String(text.suffix(text.count - 1))
                        firstTextField.text?.removeLast()
                        secondTextField.becomeFirstResponder()
                    case secondTextField:
                        thirdTextField.text = String(text.suffix(text.count - 1))
                        secondTextField.text?.removeLast()
                        thirdTextField.becomeFirstResponder()
                    case thirdTextField:
                        forthTextField.text = String(text.suffix(text.count - 1))
                        thirdTextField.text?.removeLast()
                        forthTextField.becomeFirstResponder()
                    case forthTextField:
                        fifthTextField.text = String(text.suffix(text.count - 1))
                        forthTextField.text?.removeLast()
                        fifthTextField.becomeFirstResponder()
                    case fifthTextField:
                        sixthTextField.text = String(text.suffix(text.count - 1))
                        fifthTextField.text?.removeLast()
                        sixthTextField.becomeFirstResponder()
                    case sixthTextField:
                        sixthTextField.becomeFirstResponder()
                    default:
                        break
                }
            }
        }
    }
    
    func setUpUIColor() {
        self.titleLabel.textColor = .label
        self.descLabel.textColor = .label
        self.enterOPTLabel.textColor = .label
        self.verifyButton.backgroundColor = .label
        self.resendButton.setTitleColor(.label, for: .normal)
        self.resendUnderlineView.backgroundColor = .label
        self.resendLabel.textColor = UIColor.label.withAlphaComponent(0.5)
        self.resendLabelUnderlineView.backgroundColor = UIColor.label.withAlphaComponent(0.5)
        
        self.verificationUIColor(isSuccess: true)
        self.errorLabel.textColor = .red
    }
    
    func verificationUIColor(isSuccess: Bool) {
        self.firstTextField.textColor = isSuccess ? .label : .red
        self.firstUnderline.backgroundColor = isSuccess ? .label : .red
        self.secondTextField.textColor = isSuccess ? .label : .red
        self.secondUnderline.backgroundColor = isSuccess ? .label : .red
        self.thirdTextField.textColor = isSuccess ? .label : .red
        self.thirdUnderline.backgroundColor = isSuccess ? .label : .red
        self.forthTextField.textColor = isSuccess ? .label : .red
        self.forthUnderline.backgroundColor = isSuccess ? .label : .red
        self.fifthTextField.textColor = isSuccess ? .label : .red
        self.fifthUnderline.backgroundColor = isSuccess ? .label : .red
        self.sixthTextField.textColor = isSuccess ? .label : .red
        self.sixthUnderline.backgroundColor = isSuccess ? .label : .red
        self.emptyView.isHidden = !isSuccess
        self.errorLabel.isHidden = isSuccess
    }
    
    func setUpData() {
        self.errorLabel.text = "Incorrect OTP, please try again."
        self.titleLabel.text = "Check your Email"
        self.descLabel.text = "Please check your email for the verification code."
        self.enterOPTLabel.text = "Please enter OTP to verify your account."
        
        self.verifyButton.setTitle("Verify", for: .normal)
        self.resendButton.setTitle("Resend", for: .normal)
        self.setResendTimer()
    }
    
    func setResendTimer() {
        self.startTime = Date()
        self.remainTime = self.totalTime
        self.resendLabelStackView.isHidden = false
        self.resendButtonStackView.isHidden = true
        self.resendButton.isUserInteractionEnabled = false
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        self.resendLabel.text = "Resend" + "(\(self.remainTime)s)"
        let diffSecond = Date().seconds(from: self.startTime)
        if self.remainTime > 0 {
            self.remainTime = self.totalTime - diffSecond
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        self.resendLabelStackView.isHidden = true
        self.resendButtonStackView.isHidden = false
        countdownTimer.invalidate()
        self.resendButton.isUserInteractionEnabled = true
    }

    @IBAction func verifyButtonPressed(_ sender: UIButton) {
        //TODO: Call API to check OTP
        self.verificationUIColor(isSuccess: false)
    }
    
    @IBAction func resendButtonPressed(_ sender: UIButton) {
        self.setResendTimer()
        //TODO: Call API to get new OTP
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.center.y = self.centerPoint.y - 100
        })
        
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.center.y = self.centerPoint.y
        })
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if textField == self.sixthTextField {
            return newLength <= 1
        }
        return newLength <= 2
    }
}
