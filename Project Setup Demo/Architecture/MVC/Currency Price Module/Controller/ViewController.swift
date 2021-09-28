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
        self.showLoader()
        ABNetworkManager.shared.callApiWithURLSession(strURL: URLConstant.currentPrice.rawValue) { (isSuccess, response, error) in
            self.hideLoader()
            if isSuccess {
                if let data = response as? Data {
                    let jsonDecoder = JSONDecoder()
                    let _ = try! jsonDecoder.decode(CurrencyDataModel.self, from: data)
                    self.showAlert(title: "Success", message: "Api Call Success and Data has been Parsed")
                }
            } else {
                self.showAlert(title: "Failure", message: "Api Call Failed \(error)")
            }
        }
    }
    
    /// Function call to show Alert
    /// - Parameters:
    ///   - title: Title
    ///   - message: Message
    func showAlert(title: String,message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}

