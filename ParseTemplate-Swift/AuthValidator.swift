//
//  AuthValidator.swift
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

import Foundation

private struct ValidationError {
    
    static let passwordTooShort             : UInt16 = 1 << 0
    static let passwordTooLong              : UInt16 = 1 << 1
    static let passwordContainsNoUppercase  : UInt16 = 1 << 2
    static let passwordContainsNoLowercase  : UInt16 = 1 << 3
    static let passwordContainsNoDigit      : UInt16 = 1 << 4
    static let passwordContainsNoSpecial    : UInt16 = 1 << 5
}

struct Password {
    
    static let minimumLength                = 6
    static let maximumLength                = 12
    
    static let minimumNumberOfUppercase     = 1
    static let minimumNumberOfLowercase     = 1
    static let minimumNumberOfDigit         = 1
    static let minimumNumberOfSpecial       = 1
    
    struct strength {
        
        static let veryWeak                 = "very weak"
        static let weak                     = "weak"
        static let moderate                 = "moderate"
        static let strong                   = "strong"
        static let veryStrong               = "very strong"
    }
}

extension String {
    // TODO: Actual error handling instead of prints
    func isValidEmail() -> Bool {
        
        guard matchesEmailSyntax() else {
            print("Email does not appear to have a valid syntax")
            return false
        }
        
        return true
    }
    // TODO: Actual error handling instead of prints
    func isValidPassword() -> Bool {
        
        guard isLengthWithinLimits(Password.minimumLength, maximum: Password.maximumLength) else {
            print("Password must be minimum \(Password.minimumLength) and maximum \(Password.maximumLength) characters")
            return false
        }
        
        guard containsLowercase() else {
            print("Password must contain at least \(Password.minimumNumberOfLowercase) lowercase characters")
            return false
        }
        
        guard containsUppercase() else {
            print("Password must contain at least \(Password.minimumNumberOfUppercase) uppercase characters")
            return false
        }
        
        guard containsDigit() else {
            print("Password must contain at least \(Password.minimumNumberOfDigit) digits")
            return false
        }
        
        guard containsSpecial() else {
            print("Password must contain at least \(Password.minimumNumberOfSpecial) special characters")
            return false
        }
        
        return true
    }
    
    private func matchesEmailSyntax() -> Bool {
        // TODO: Can the return options be made more concise?
        if let _ = self.rangeOfString("^.+@.+\\..+$", options: .RegularExpressionSearch) {
            return true
        }
        return false
    }
    // TODO: suppress argument names
    private func isLengthWithinLimits(minimum: Int, maximum: Int) -> Bool {
        return (self.characters.count >=  minimum) && (self.characters.count <= maximum)
    }
    
    private func containsLowercase() -> Bool {
        
        var count = 0
        for char in "abcdefghijklmnopqrstuvwxyz".characters {
            if self.characters.contains(char) {
                if ++count >= Password.minimumNumberOfLowercase {
                    return true
                }
            }
        }
        return false
    }
    
    private func containsUppercase() -> Bool {
        
        var count = 0
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters {
            if self.characters.contains(char) {
                if ++count >= Password.minimumNumberOfLowercase {
                    return true
                }
            }
        }
        return false
    }
    
    private func containsDigit() -> Bool {
        
        var count = 0
        for i in 0...9 {
            if self.containsString(String(i)) {
                if ++count >= Password.minimumNumberOfDigit {
                    return true
                }
            }
        }
        return false
    }
    
    private func containsSpecial() -> Bool {
        
        var count = 0
        for char in "!@#$%^&*?+-".characters {
            if self.characters.contains(char) {
                if ++count >= Password.minimumNumberOfSpecial {
                    return true
                }
            }
        }
        return false
    }
}