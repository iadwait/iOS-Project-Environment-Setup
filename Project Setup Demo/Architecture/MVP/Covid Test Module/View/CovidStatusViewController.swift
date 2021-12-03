//
//  CovidStatusViewController.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 03/12/21.
//

import UIKit

/// This class is controller for Covid Details View
class CovidStatusViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tblViewCovidDetails: UITableView!
    
    // MARK: - Variable Declaration
    let objCovidPresenter = CovidPresenter()
    var arrLeftRightData = [LeftRightModel]()
    
    // MARK: - View's Initialization Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        objCovidPresenter.attachView(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
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

    func setupUI() {
        
    }
    
    /// Function Call to
    func configureTableView() {
        tblViewCovidDetails.register(UINib(nibName: "LeftRightCell", bundle: nil), forCellReuseIdentifier: "LeftRightCell")
        tblViewCovidDetails.delegate = self
        tblViewCovidDetails.dataSource = self
        tblViewCovidDetails.separatorStyle = .none
    }
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
        arrLeftRightData.removeAll()
        // Append New Data
        arrLeftRightData.append(LeftRightModel.createObject(leftLabelData: "Date", rightLabelData: "\(objCovid.date ?? 0)"))
        arrLeftRightData.append(LeftRightModel.createObject(leftLabelData: "States", rightLabelData: "\(objCovid.states ?? 0)"))
        arrLeftRightData.append(LeftRightModel.createObject(leftLabelData: "Positive Cases", rightLabelData: "\(objCovid.positive ?? 0)"))
        arrLeftRightData.append(LeftRightModel.createObject(leftLabelData: "Negative Cases", rightLabelData: "\(objCovid.negative ?? 0)"))
        arrLeftRightData.append(LeftRightModel.createObject(leftLabelData: "Pending Tests", rightLabelData: "\(objCovid.pending ?? 0)"))
        arrLeftRightData.append(LeftRightModel.createObject(leftLabelData: "Total Cases", rightLabelData: "\(objCovid.total ?? 0)"))
        arrLeftRightData.append(LeftRightModel.createObject(leftLabelData: "Recovered Cases", rightLabelData: "\(objCovid.recovered ?? "Not Received")"))
        // Update UI
        DispatchQueue.main.async {
            self.tblViewCovidDetails.reloadData()
        }
    }
    
    /// Function call if any error occur during api calling or parsing
    /// - Parameter message: Error Message
    func showError(message: String) {
        self.showAlert(title: "", message: message)
    }
    
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension CovidStatusViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLeftRightData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewCovidDetails.dequeueReusableCell(withIdentifier: "LeftRightCell", for: indexPath) as! LeftRightCell
        let data = arrLeftRightData[indexPath.row]
        cell.lblLeftLabel.text = data.leftData
        cell.lblRightLabel.text = data.rightData
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
