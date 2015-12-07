//
//  MainViewController.swift
//  ParseTemplate-Swift
//
//  Created by Norbert Metz on 04/12/2015.
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

class MainViewController: UIViewController {
    
    @IBOutlet weak var userDetailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let user = PFUser.currentUser()
        
        if user == nil || !user!.authenticated {
            print("User not logged in")
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        } else {
            
            // Construct user details label
            
            var userDetails: String = ""
            
            userDetails += "First name: \(constructUserDetailSring(user?.objectForKey("firstName")))\n"
            userDetails += "Last name: \(constructUserDetailSring(user?.objectForKey("lastName")))\n"
            userDetails += "Email: \(constructUserDetailSring(user?.email))\n"
            userDetails += "Phone: \(constructUserDetailSring(user?.objectForKey("phone")))\n"
            userDetails += "Marketing consent: \(constructUserDetailSring(user?.objectForKey("marketingConsent")))\n"
            userDetails += "Member since: \(constructUserDetailSring(user?.createdAt))\n"
            userDetails += "Account activated: \(constructUserDetailSring(user?.objectForKey("emailVerified")))\n"
            
            userDetailsLabel.text = userDetails
        }
    }
    
    @IBAction func logOutButtonTapped(sender: UIBarButtonItem) {
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
            
            guard error == nil else {
                print("Log out error occurred: \(error?.localizedDescription)")
                return
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    private func constructUserDetailSring(userDetail: AnyObject?) -> String {
        
        switch userDetail {
            
        case is String:
            return userDetail as! String
            
        case is Bool:
            return userDetail as! Bool ? "Yes" : "No"
            
        case is NSDate:
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            formatter.timeStyle = .ShortStyle
            return formatter.stringFromDate(userDetail as! NSDate)
            
        default:
            if userDetail != nil { print(userDetail!.dynamicType) }
        }
        
        return "N/A"
    }
}
