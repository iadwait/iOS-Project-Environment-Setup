//
//  ViewController.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 27/09/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lblAppVersion: UILabel!
    
    // MARK: - Variable Declaration
    let objEnv = EnvironmentSetup.shared
    let isCertificatePinning = true
    
    // MARK: - View's Initialization Methods
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
    
    
    // MARK: - IBActions
    
    /// Function Call when Button SSL Pinning is Tapped
    /// - Parameter sender: UIButton
    @IBAction func btnSSLPinningTapped(_ sender: UIButton) {
        ABNetworkManager.shared.callApiWithURLSession_SSLPinning(withURL: "https://www.google.co.uk", isSSLPinning: true, isCertificatePinning: isCertificatePinning, sslCertificateName: Constants.sslCertificateName) { (isSuccess, response, error) in
            if isSuccess {
                if self.isCertificatePinning {
                    self.showAlert(title: "Success", message: "Certificate Pinning Successfully Done")
                } else {
                    self.showAlert(title: "Success", message: "Public Key Pinning Successfully Done")
                }
            } else {
                if self.isCertificatePinning {
                    self.showAlert(title: "Failure", message: "Certificate Pinning Failed")
                } else {
                    self.showAlert(title: "Failure", message: "Public Key Pinning Failed")
                }
            }
        }
    }
    
    
    // MARK: - User Defined Functions
    
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

