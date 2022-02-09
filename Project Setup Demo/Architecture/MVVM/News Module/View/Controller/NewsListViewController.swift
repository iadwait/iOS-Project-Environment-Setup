//
//  NewsListViewController.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 09/02/22.
//

import UIKit

/// This class contains Controller for News List View
class NewsListViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tblViewNewsDetails: UITableView!
    @IBOutlet weak var btnGetUpdatedNews: UIButton!
    
    // MARK: - Variable Declarations
    var arrNewsData = [Articles]()
    
    // MARK: - View's Initialization Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
    }
    
    // MARK: - User Defined Functions
    
    /// Function to setup Screen UI
    func setupUI() {
        btnGetUpdatedNews.titleLabel?.font = UIFont(name: ABThemeConstant.shared.fuzzyBubbles, size: 25)
    }
    
    /// Function Call to
    func configureTableView() {
        tblViewNewsDetails.register(UINib(nibName: "NewsDataTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsDataTableViewCell")
        tblViewNewsDetails.delegate = self
        tblViewNewsDetails.dataSource = self
        tblViewNewsDetails.separatorStyle = .none
    }
    
    // MARK: - IBActions
    
    /// Function call when user taps on Get Updated News button
    /// - Parameter sender: UIButton
    @IBAction func btnGetUpdatedNewsTapped(_ sender: UIButton) {
        NewsDataViewModel.getUpdatedNewsData(target: self) { (isSuccess, arrNewsData, error) in
            if isSuccess {
                // Updated Data
                self.arrNewsData.removeAll()
                self.arrNewsData = (arrNewsData?.articles)!
                // Reload TableView
                DispatchQueue.main.async {
                    self.tblViewNewsDetails.reloadData()
                }
            } else {
                self.showAlert(title: "Failed", message: error)
            }
        }
    }
    
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension NewsListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNewsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewNewsDetails.dequeueReusableCell(withIdentifier: "NewsDataTableViewCell", for: indexPath) as! NewsDataTableViewCell
        let data = arrNewsData[indexPath.row]
        if data.urlToImage != "" && data.urlToImage != nil {
            cell.imgView.load(url: URL(string: data.urlToImage!)!)
            cell.imgView.contentMode = .scaleToFill
        }
        cell.lblTitle.text = data.title ?? "N/A"
        cell.lblDesc.text = data.description ?? "N/A"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
}
