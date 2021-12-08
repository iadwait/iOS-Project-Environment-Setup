//
//  Enums.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 27/09/21.
//

import Foundation

/// This Enum Contains all plist Files Raw Values
enum plistFiles: String {
    case UAT = "UAT"
    case PreProd = "PreProd"
    case CUG = "CUG"
    case PROD = "PROD"
    case ColorData = "ColorData"
    case iPhoneSmall = "iPhoneSmall"
    case iPhoneMedium = "iPhoneMedium"
    case iPhoneLarge = "iPhoneLarge"
}

/// Enum that will contain Base URL's for all Environments
enum BaseURL: String {
    case UAT = "www.uat.com"
    case PreProd = "www.preprod.com"
    case CUG = "www.cug.com"
    case PROD = "www.prod.com"
}

/// This Enum will hold all URL's excluding BaseURL's
enum URLConstant: String {
    case currentPrice = "https://api.coindesk.com/v1/bpi/currentprice.json"
}

/// Enum to Decide wihch SHA Algoritm to Apply
enum SHAType: String {
    case SHA256
    case SHA192
}
