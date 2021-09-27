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
        if let releaseType = objEnv.releaseType,let appVersion = objEnv.appVersion {
            lblAppVersion.text = "\(releaseType) : \(appVersion)"
        }
    }

}

