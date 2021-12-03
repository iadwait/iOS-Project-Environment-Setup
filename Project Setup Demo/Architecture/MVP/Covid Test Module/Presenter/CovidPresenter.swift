//
//  CovidPresenter.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 03/12/21.
//

import Foundation

/// This Presenter will manage Api Calls for Covid Module
class CovidPresenter {
    
    var covidView: covidPresenterDelegate?
    
    /// Attach Controller instance
    /// - Parameter attachView: Any Controller which Confirms to covidPresenterDelegate
    func attachView(_ attachView: covidPresenterDelegate) {
        self.covidView = attachView
    }
    
    /// Detach Controller Instance
    func detachView() {
        self.covidView = nil
    }
    
    /// Function call to get Covid Details
    func getUpdatedCovidStatus() {
        
        // Show Loader
        self.covidView?.showSpinner()
        
        // Request Formation if Any
        
        // Api Call Here
        ABNetworkManager.shared.callApiWithURLSession(strURL: "https://api.covidtracking.com/v1/us/current.json") { (isSucces, response, error) in
            
            self.covidView?.hideSpinner()
            
            if isSucces {
                // Perform Parsing
                if let data = response as? Data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let objCovidData = try jsonDecoder.decode([CovidDataModel].self, from: data)
                        self.covidView?.getCovidStatus(objCovid: objCovidData[0])
                    } catch let error {
                        self.covidView?.showError(message: error.localizedDescription)
                    }
                } else {
                    self.covidView?.showError(message: "An unexpected error occur, Please try again Later")
                }
            } else {
                if error != "" {
                    self.covidView?.showError(message: error)
                } else {
                    self.covidView?.showError(message: "An unexpected error occur, Please try again Later")
                }
            }
            
        }
    }
    
}
