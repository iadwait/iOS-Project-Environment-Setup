//
//  ABThemeConstant.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 27/09/21.
//

import Foundation

/// This Class Will Contain List of Colours Added in ColorData.plist
class ABThemeConstant {
    
    static let shared = ABThemeConstant()
    
    // MARK: - Color Constants
    // Make Sure to add Colors in ColorData.plist along with proper HexCode
    let White = "White"
    let Yellow = "Yellow"
    let LightOrange = "LightOrange"
    
    // MARK: - Font Sizes
    // Make Sure to add Font Sizes in iPhoneSmall,iPhoneMedium,iPhoneLarge Plist Files
    let FontSizeS = "FontSizeS"
    let FontSizeM = "FontSizeM"
    let FontSizeL = "FontSizeL"
    
    // MARK: - Font Names
    // Make Sure to Drag Drop font files (.ttf) in Common -> Fonts
    // Than Add Font Name in info.plist under "Fonts provided by application" Row
    // Note: - Font Name as sometimes different than Font File name to check name you can print all font names used in application using print(UIFont.familyNames)
    let fuzzyBubbles = "Fuzzy Bubbles"
    
}
