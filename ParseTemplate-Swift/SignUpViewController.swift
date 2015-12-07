//
//  SignUpViewController.swift
//  ParseTemplate-Swift
//
//  Created by Norbert Metz on 29/11/2015.
//  Copyright © 2015 Norbert Metz. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Parse
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var marketingConsentCheckBox: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate     = self
        passwordTextField.delegate  = self
        
        passwordTextField.addTarget(self, action: "passwordTextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        switch textField {
            
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            
        default: break
        }
        
        return true
    }
    
    // MARK: Button Actions
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(sender: UIButton) {
        print("Create Account Button Tapped")
        
        dismissKeyboard()
        
        // Validate email
        
        guard emailTextField.text!.isValidEmail() else {
            emailTextField.shake()
            return
        }
        
        // Validate password
        
        guard passwordTextField.text!.isValidPassword() else {
            passwordTextField.shake()
            return
        }
        
        // Register user
        
        let user = PFUser()
        
        user.username   = emailTextField.text
        user.email      = emailTextField.text
        user.password   = passwordTextField.text
        user.setObject(marketingConsentCheckBox.checked, forKey: "marketingConsent")
        
        // TODO: Add weak referencing
        user.signUpInBackgroundWithBlock { success, error in
            
            if (success) {
                
                // Registration successful
                
                print("Registration successful")
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
            } else if let error = error {
                
                // Registration error
                
                print("Registration error: \(error.localizedDescription)")
            }
        }
    }
    
    func passwordTextFieldDidChange(textField: UITextField) {
        // Password on-the-fly validation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
