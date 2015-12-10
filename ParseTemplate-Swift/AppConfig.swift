//
//  ApplicationConfig.swift
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

/**
*  Application configuration
*/
struct AppConfig {
    
}

/**
 *
 *  Parse configuration
 *
 *  applicationId:  This is the main identifier that uniquely specifies your application. This is paired with a key to provide your clients access to your application's data.
 *  clientKey:      This key should be used in consumer clients, like the iOS or Android SDK. It adheres to object level permissions.
 *
 *  1. Go to https://www.parse.com/apps/
 *  2. Select your App
 *  3. Go to Settings (in top menu)
 *  4. Go to Keys (in left menu)
 *  5. Copy and paste Application ID and Client Key into respective constant placeholders below
 *
 */
struct ParseConfig {
    
    static let applicationId        = "4ppL1c4T10N1DpL4c3H0ld3r"
    static let clientKey            = "cLi3n7K3yPl4c3h0lD3R"
}

/**
*
*  Facebook configuration
*
*  1. Go to https://developers.facebook.com/
*  2. Select My Apps > [Your App name]
*  3. Go to Dashboards (left hand side)
*  4. Copy and paste App ID into CFBundleURLSchemes and FacebookAppID placeholders (found in Info.plist)
*/
struct FacebookConfig {
    
    static let loginPermissions         = ["public_profile", "email"]
    static let userDetailsParameters    = ["fields": "id, email, first_name, last_name"]
}
