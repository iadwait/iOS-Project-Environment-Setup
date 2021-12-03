//
//  CovidStatusViewController.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 03/12/21.
//

import UIKit

/// This class is controller for Covid Details View
class CovidStatusViewController: BaseViewController {

    // MARK: - Variable Declaration
    let objCovidPresenter = CovidPresenter()
    
    // MARK: - View's Initialization Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        objCovidPresenter.attachView(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        objCovidPresenter.detachView()
    }
    
    // MARK: - IBActions
    
    /// Function call when user taps on Get Covid Details Function
    /// - Parameter sender: UIButton
    @IBAction func btnGetCovidDetailsTapped(_ sender: UIButton) {
        objCovidPresenter.getUpdatedCovidStatus()
    }
    
    
    // MARK: - User Defined Functions

}

// MARK: - Extensions

// MARK: - covidPresenterDelegate
extension CovidStatusViewController: covidPresenterDelegate {
    
    /// Function call to show loader
    func showSpinner() {
        self.showLoader()
    }
    
    /// Function call to hide loader
    func hideSpinner() {
        self.hideLoader()
    }
    
    /// Function call when Api call was successfully done
    /// - Parameter objCovid: Covid Details Object
    func getCovidStatus(objCovid: CovidDataModel) {
        
    }
    
    /// Function call if any error occur during api calling or parsing
    /// - Parameter message: Error Message
    func showError(message: String) {
        self.showAlert(title: "", message: message)
    }
    
}
