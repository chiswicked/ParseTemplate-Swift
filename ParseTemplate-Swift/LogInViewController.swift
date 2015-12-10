//
//  ViewController.swift
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
import ParseFacebookUtilsV4
import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var parseLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate     = self
        passwordTextField.delegate  = self
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // [OPTIONAL] Basic Facebook login button for testing
        
        // let loginButton = FBSDKLoginButton.init(type: UIButtonType.RoundedRect)
        // loginButton.center = self.view.center;
        // self.view.addSubview(loginButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let token = PFUser.currentUser()?.sessionToken
        print("Token: \(token)")
        
        if let user = PFUser.currentUser() {
            if user.authenticated {
                print("User authenticated")
                performSegueWithIdentifier("fromLogInToMain", sender: nil)
            }
        }
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
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        print("Log In Button Tapped")
        
        switch sender {
            
        case parseLoginButton:

            dismissKeyboard()
        
            // Validate email
            
            guard !emailTextField.text!.isEmpty else {
                emailTextField.shake()
                return
            }
            
            // Validate password
            
            guard !passwordTextField.text!.isEmpty else {
                passwordTextField.shake()
                return
            }
        
            // Authenticate user
 
                PFUser.logInWithUsernameInBackground(emailTextField.text!, password: passwordTextField.text!) { user, error in
                    
                    if let user = PFUser.currentUser() {
                        if user.authenticated {
                            
                            // Parse login successful
                            print("Log in succesful: \(PFUser.currentUser())")
                            self.passwordTextField.text = ""
                            self.performSegueWithIdentifier("fromLogInToMain", sender: nil)
                        }
                    } else if let error = error {
                        
                        // Parse login error
                        print("Log in error: \(error.localizedDescription)")
                    }
                }
            
        case facebookLoginButton:
            
            PFFacebookUtils.logInInBackgroundWithReadPermissions(FacebookConfig.loginPermissions) { (user:PFUser?, error: NSError?) in
                if let user = PFUser.currentUser() {
                    if user.authenticated {
                        
                        // Facebook login successful
                        print("Log in succesful: \(PFUser.currentUser())")
                        self.passwordTextField.text = ""
                        
                        
                        print("New user: \(user.isNew)")
                        if user.isNew {
                            
                            // Loggen in with Facebook for the first time (sign up)
                            let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: FacebookConfig.userDetailsParameters)
                            userDetails.startWithCompletionHandler() { (connection, result, error) in
                                if let user = PFUser.currentUser() {
                                    
                                    let userEmail               = result["email"] as? String
                                    let userFirstName           = result["first_name"] as? String
                                    let userLastName            = result["last_name"] as? String
                                    let userMarketingConsent    = false
                                    
                                    user.email = userEmail
                                    user.setObject(userFirstName!, forKey: "firstName")
                                    user.setObject(userLastName!, forKey: "lastName")
                                    user.setObject(userMarketingConsent, forKey: "marketingConsent")
                                    
                                    user.saveInBackgroundWithBlock() { (success: Bool, erro:NSError?) in
                                        if success {
                                            print("Successfully updated user details")
                                        }
                                        // TODO: Proper segueing in main thread
                                    }
                                }
                            }
                        }
                        self.performSegueWithIdentifier("fromLogInToMain", sender: nil)
                    }
                } else if let error = error {
                    
                    // Facebook login error
                    print("Log in error: \(error.localizedDescription)")
                }
            }
            
        default: break
        }
    }
    
    @IBAction func resetPasswordButtonTapped(sender: UIButton) {
        print("Password Reset Button Tapped")
        
        performSegueWithIdentifier("fromLogInToResetPassword", sender: nil)
    }
    
    @IBAction func signUpButtonTapped(sender: UIButton) {
        print("Sign Up Button Tapped")
        
        performSegueWithIdentifier("fromLogInToSignUp", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fromLogInToSignUp" {
            print("Segueing fromLogInToSignUp")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

