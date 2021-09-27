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
    
}
