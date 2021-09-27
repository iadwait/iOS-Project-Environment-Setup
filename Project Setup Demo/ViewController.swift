//
//  ViewController.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 27/09/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lblAppVersion: UILabel!
    
    let objEnv = EnvironmentSetup.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Access Plist Details based on Environment/Scheme Selected
        if let releaseType = objEnv.releaseType,let appVersion = objEnv.appVersion {
            lblAppVersion.text = "\(releaseType) : \(appVersion)"
        }
        // Set Colors
        self.view.backgroundColor =  ABUtils.shared.convertHexColor(forColor: ABThemeConstant.shared.LightOrange)
        // Set Font
        self.lblAppVersion.font = ABUtils.shared.getSpecificFontSize(fontSize: ABThemeConstant.shared.FontSizeM)
        // Api Calls
        ABNetworkManager.shared.callApiWithURLSession(strURL: "https://api.coindesk.com/v1/bpi/currentprice.json") { (isSuccess, response, error) in
            if isSuccess {
                print("Api Call Success")
            } else {
                print("Api Call Failed \(error)")
            }
        }
    }

}

