//
//  ABNetworkManager.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 27/09/21.
//

import Foundation

/// This Class will Manage all Api Calls with URL Sessions/Alamofire
class ABNetworkManager {
    
    static let shared = ABNetworkManager()
    var task:URLSessionDataTask!
    
    /// Function Call to get Api Response using URL Session
    /// - Parameters:
    ///   - strURL: URL in string format
    ///   - completion: Return Api Response/Error
    func callApiWithURLSession(strURL: String, completion: @escaping (_ isSuccess: Bool,_ responseData: Any,_ error: String) -> Void) {
        // Generate URL
        if let url = URL(string: strURL) {
            task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Check for Error
                if error != nil {
                    completion(false,"",error!.localizedDescription)
                } else {
                    // Check if Data is Present
                    if let _ = data {
                        let actualResponse = String(decoding: data!, as: UTF8.self)
                        print("Response = \(actualResponse)")
                        completion(true,data!,"")
                    }
                }
            }
            task.resume()
            
        } else {
            // Failed to generate URL
            completion(false,"","Failed to Generate URL")
        }
    }
    
}
