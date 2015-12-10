//
//  UIExtensions.swift
//  ParseTemplate-Swift
//
//  Created by Norbert Metz on 30/11/2015.
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

import UIKit

extension UITextField {
    
    func shake(color: CGColor? = UIColor.redColor().CGColor, receiveFocus: Bool = true) {
        
        if let color = color {
            startGlow(color, intensity: 0.8)
        }
        self.transform = CGAffineTransformMakeTranslation(-10, 0)
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: .CurveEaseOut, animations: {
            self.transform = CGAffineTransformIdentity
            }, completion: { finished in
                
                if color != nil {
                    self.stopGlow()
                }
                
                if receiveFocus {
                    self.becomeFirstResponder()
                }
        })
    }
    
    func stopGlow() {
        self.layer.shadowColor = nil
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0;
    }
    
    func startGlow(color: CGColor, intensity: CGFloat) {
        self.layer.shadowColor = color
        self.layer.shadowRadius = intensity
        self.layer.shadowOpacity = 0.9;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.masksToBounds = false
    }
    
    func setIcon(named: String) {
        let icon = UIImage(named: named)
        self.rightView = UIImageView(image: icon)
        self.rightViewMode = .Always
    }
}
