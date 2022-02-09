//
//  NewsDataViewModel.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 09/02/22.
//

import Foundation
import UIKit

/// This class will act as View Model for News Data Module
class NewsDataViewModel: BaseViewController {
    
    /// Function call to Get Updated New Data
    /// - Parameters:
    ///   - target: Your View's Instance
    ///   - completion: Response
    class func getUpdatedNewsData(target: UIViewController,completion: @escaping(Bool,NewsDataModel?,String) -> Void) {
        
        // Show Loader
        target.showLoader()
        
        // Request Formation if Any
        
        // Api Call Here
        ABNetworkManager.shared.callApiWithURLSession(strURL: "https://newsapi.org/v2/top-headlines?country=in&apiKey=25282fd75a1d44198feb661175707321") { (isSucces, response, error) in
            
            // Hide Loader
            target.hideLoader()
            
            if isSucces {
                // Perform Parsing
                if let data = response as? Data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let objNewsData = try jsonDecoder.decode(NewsDataModel.self, from: data)
                        completion(true,objNewsData,"")
                    } catch let _ {
                        completion(false,nil,"Response Data Parsing Failed")
                    }
                } else {
                    completion(false,nil,"An unexpected error occur, Please try again Later")
                }
            } else {
                if error != "" {
                    completion(false,nil,"An unexpected error occur, Please try again Later")
                } else {
                    completion(false,nil,"An unexpected error occur, Please try again Later")
                }
            }
            
        }
    }
    
}
