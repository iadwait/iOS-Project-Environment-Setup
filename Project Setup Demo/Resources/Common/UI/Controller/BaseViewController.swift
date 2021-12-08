//
//  BaseViewController.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 03/12/21.
//

import UIKit

/// This Class will contain all Reusable UI Functions, All Controller's should keep their super call as BaseViewController
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
