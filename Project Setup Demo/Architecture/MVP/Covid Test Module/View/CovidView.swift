//
//  CovidView.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 03/12/21.
//

import Foundation

/// Delegate Methods to handle UI
protocol covidPresenterDelegate {
    func showSpinner()
    func hideSpinner()
    func getCovidStatus(objCovid: CovidDataModel)
    func showError(message: String)
}
