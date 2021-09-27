//
//  ABUtils.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 27/09/21.
//

import Foundation
import UIKit

/// This ABUtils Class will contains all the Reusable Functions
class ABUtils {
    
    static let shared = ABUtils()
    
    /// This Function will return UI Color
    /// - Parameter forColor: Color Name
    /// - Returns: UIColor
    func convertHexColor(forColor: String) -> UIColor {
        // Read Color Data Plist
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "ColorData", ofType: "plist") {
              myDict = NSDictionary(contentsOfFile: path)
            let color = UIColor(hexString: myDict![forColor] as! String)
            return color
        }
        // If UIColor is missing in ColorData.plist File Default White will be returned
        return UIColor(hexString: "#FFFFF")
    }
    
    /// Function Call to get UIFont of Specified Size
    /// - Parameter fontSize: Font Size
    /// - Returns: UIFont
    func getSpecificFontSize(fontSize: String) -> UIFont {
        //TODO:- Add Font Name
        // Check if iPhone is Small , Medium or Large
        var myDict: NSDictionary?
        //This Condition is to handle UI for Smallest iPhone like SE,4s,5,5s which have height of 568
        if UIScreen.main.bounds.height <= 568 {
            if let fontPlistPath = Bundle.main.path(forResource: "iPhoneSmall", ofType: "plist") {
                myDict = NSDictionary(contentsOfFile: fontPlistPath)
                if let _ = myDict {
                    let strFontSize = myDict![fontSize]
                    if let n = NumberFormatter().number(from: strFontSize as! String) {
                        return UIFont.systemFont(ofSize: CGFloat(truncating: n))
                    }
                }
            }
        }
        //This Condition is for all Devices having height greater than iPhone 8
        else if UIScreen.main.bounds.height > 667.0 {
            if let fontPlistPath = Bundle.main.path(forResource: "iPhoneLarge", ofType: "plist") {
                myDict = NSDictionary(contentsOfFile: fontPlistPath)
                if let _ = myDict {
                    let strFontSize = myDict![fontSize]
                    if let n = NumberFormatter().number(from: strFontSize as! String) {
                        return UIFont.systemFont(ofSize: CGFloat(truncating: n))
                    }
                }
            }
        }
        // Medium Size Devices
        else {
            if let fontPlistPath = Bundle.main.path(forResource: "iPhoneMedium", ofType: "plist") {
                myDict = NSDictionary(contentsOfFile: fontPlistPath)
                if let _ = myDict {
                    let strFontSize = myDict![fontSize]
                    if let n = NumberFormatter().number(from: strFontSize as! String) {
                        return UIFont.systemFont(ofSize: CGFloat(truncating: n))
                    }
                }
            }
        }
        return UIFont.systemFont(ofSize: 10)
    }
    
}
