//
//  ABNetworkManager.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 27/09/21.
//

import Foundation
import CommonCrypto
import Alamofire

/// This Class will Manage all Api Calls with URL Sessions/Alamofire
class ABNetworkManager: NSObject {
    
    static let shared = ABNetworkManager()
    var task:URLSessionDataTask!
    var sslCertificateName = ""
    var isCertificatePinning = Bool()
    static let publicKeyHash = "xucKip6j7mWOyo3bckw4d9SBBL3EsFqiBM2nGxM5N+E="
    let rsa2048Asn1Header:[UInt8] = [
        0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
        0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
    ]
    private func sha256(data : Data) -> String {
        var keyWithHeader = Data(rsa2048Asn1Header)
        keyWithHeader.append(data)
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        keyWithHeader.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(keyWithHeader.count), &hash)
        }
        return Data(hash).base64EncodedString()
    }
    
    // MARK: - URL Session Methods
    
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
    
    /// Function Call to check for SSL Pinning and hit Api
    /// - Parameters:
    ///   - url: Api Url
    ///   - isSSLPinning: Whether to check for SSL Pinning
    ///   - isCertificatePinning: Certificate Pinning / Public Key Pinning
    ///   - sslCertificateName: SSL Certificate Name
    ///   - completion: Return Response Block
    func callApiWithURLSession_SSLPinning(withURL url: String,isSSLPinning: Bool,isCertificatePinning: Bool,sslCertificateName: String,completion: @escaping (_ isSuccess: Bool,_ responseData: Any,_ error: String) -> Void) {
        self.sslCertificateName = sslCertificateName
        let session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
        self.isCertificatePinning = isCertificatePinning
        var responseMessage = ""
        if let url = URL(string: url) {
            let task = session.dataTask(with: url) { (data, response, error) in
                var isSuccess = true
                if error != nil {
                    isSuccess = false
                    print("error: \(error!.localizedDescription): \(error!)")
                    responseMessage = "Pinning failed"
                } else if data != nil {
                    isSuccess = true
                    let str = String(decoding: data!, as: UTF8.self)
                    print("Received data:\n\(str)")
                    if isCertificatePinning {
                        responseMessage = "Certificate pinning is successfully completed"
                    }else {
                        responseMessage = "Public key pinning is successfully completed"
                    }
                }
                DispatchQueue.main.async {
                    completion(isSuccess,response,responseMessage)
                }
            }
            task.resume()
        } else {
            completion(false,"","Error forming URL")
        }
    }
    
    // MARK: - Alamofire Methods
    
    /// Function call to hit Api using Alamofire
    /// - Parameters:
    ///   - url: URL Reqest
    ///   - completion: Response Block
    func callApiWithAlamofire(withURL url: String,completion: @escaping(_ isSuccess: Bool,_ response: Any?,_ error: String) -> Void) {
        if let url = URL(string: url) {
            AF.request(url).response { (responseObject) in
                switch responseObject.result {
                case .success(let value):
                    if let resData = value {
                        let resString = String(data: resData, encoding: .utf8)
                        print("Response = \(resString ?? "")")
                        completion(true,resData,"")
                    } else {
                        completion(false,nil,"No Data Received from Backend")
                    }
                case .failure(let error):
                    print("Alamofire Failure - \(error)")
                }
            }
        }
    }
    
}

// MARK: - Extensions

// MARK: - URLSessionDelegate
extension ABNetworkManager: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil);
            return
        }
        
        if self.isCertificatePinning {
            
            
            let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)
            // SSL Policies for domain name check
            let policy = NSMutableArray()
            policy.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
            
            //evaluate server certifiacte
            let isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)
            
            //Local and Remote certificate Data
            let remoteCertificateData:NSData =  SecCertificateCopyData(certificate!)
            //let LocalCertificate = Bundle.main.path(forResource: "github.com", ofType: "cer")
            let pathToCertificate = Bundle.main.path(forResource: self.sslCertificateName, ofType: "cer")
            let localCertificateData:NSData = NSData(contentsOfFile: pathToCertificate!)!
            
            //Compare certificates
            if(isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData as Data)){
                let credential:URLCredential =  URLCredential(trust:serverTrust)
                print("Certificate pinning is successfully completed")
                completionHandler(.useCredential,credential)
            }
            else{
                completionHandler(.cancelAuthenticationChallenge,nil)
            }
        } else {
            if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                // Server public key
                let serverPublicKey = SecCertificateCopyKey(serverCertificate)
                let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublicKey!, nil )!
                let data:Data = serverPublicKeyData as Data
                // Server Hash key
                let serverHashKey = sha256(data: data)
                // Local Hash Key
                let publickKeyLocal = type(of: self).publicKeyHash
                if (serverHashKey == publickKeyLocal) {
                    // Success! This is our server
                    print("Public key pinning is successfully completed")
                    completionHandler(.useCredential, URLCredential(trust:serverTrust))
                    return
                } else {
                    print("Public key pinning Failed")
                    completionHandler(.cancelAuthenticationChallenge,nil)
                }
            }
        }
    }
    
}
