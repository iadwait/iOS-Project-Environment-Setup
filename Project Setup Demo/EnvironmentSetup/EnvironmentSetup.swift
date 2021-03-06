//
//  EnvironmentSetup.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 27/09/21.
//

import Foundation

/// This Class is created to configure Project based on Env Selected
class EnvironmentSetup: Codable {
    
    static let shared = EnvironmentSetup()
    
    var baseURL: String?
    var appVersion: String?
    var releaseType: String?
    var plistData: Config?
    var plistUrl: URL?
    
    /// Function Call for Project Setup based on Selected Environment
    func configure() {
        // Setup BASE URL
        #if UAT
        self.baseURL = BaseURL.UAT.rawValue
        #elseif PreProd
        self.baseURL = BaseURL.PreProd.rawValue
        #elseif CUG
        self.baseURL = BaseURL.CUG.rawValue
        #elseif PROD
        self.baseURL = BaseURL.PROD.rawValue
        #endif
        
        // Get plist Data
        self.plistData = parseConfig()
        if plistData != nil {
            self.appVersion = plistData!.AppVersion
            self.releaseType = plistData!.ReleaseType
        }
    }
    
    /// Function call to get Plist Date based on Environment Selected
    /// - Returns: Ojbject
    func parseConfig() -> Config {
        #if UAT
        self.plistUrl = Bundle.main.url(forResource: plistFiles.UAT.rawValue, withExtension: "plist")!
        #elseif PreProd
        self.plistUrl = Bundle.main.url(forResource: plistFiles.PreProd.rawValue, withExtension: "plist")
        #elseif CUG
        self.plistUrl = Bundle.main.url(forResource: plistFiles.CUG.rawValue, withExtension: "plist")!
        #elseif PROD
        self.plistUrl = Bundle.main.url(forResource: plistFiles.PROD.rawValue, withExtension: "plist")!
        #endif
        let data = try! Data(contentsOf: plistUrl!)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(Config.self, from: data)
    }
    
}

/// Decoding Class for plist Files
class Config: Codable {
    private enum CodingKeys: String, CodingKey {
        case AppVersion, ReleaseType
    }
    let AppVersion: String
    let ReleaseType: String
}
