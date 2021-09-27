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
    }

}

