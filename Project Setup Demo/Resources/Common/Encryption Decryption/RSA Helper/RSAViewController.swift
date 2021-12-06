//
//  RSAViewController.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 06/12/21.
//  Copyright - Aman Gangurde (Winjit Technologies)

import UIKit

///class to achieve RSA encryption decryption using Parser
class RSAViewController: UIViewController {
    
    //MARK:- Variable Declarations
    var rsaComponents: [RSAComponent] = []
    var elementName: String = String()
    var modulus = String()
    var exponent = String()
    var sequenceEncoded: [UInt16] = []
    
    convenience init () {
        self.init(nibName: nil, bundle: nil)
    }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /// Func call when you have RSA Key / Public Key in Base 64 Format and Public Key needs to be formed
    /// - Parameters:
    ///   - DataToEncrypt: Data to Encrypt
    ///   - RSAKey: Base 64 Encoded Key
    /// - Returns: Encrypted Text
    public func getRSAEncryptedData(DataToEncrypt:String,RSAKey : String) -> String
    {
        //decode base64 string
        let decodedData = Data(base64Encoded: RSAKey)!
        let decodedString = String(data: decodedData, encoding: .utf8)!
        
        //parse xml
        let parser = XMLParser.init(data: Data(decodedString.utf8))
        parser.delegate = self
        parser.parse()
        
        //public key generation
        let modulusString = self.rsaComponents[0].modulus
        let exponentString = self.rsaComponents[0].exponent
        
        let mod = Data(base64Encoded: modulusString)!
        let exp = Data(base64Encoded: exponentString)!
        
        let modulusData = [UInt8](mod)
        let exponentData = [UInt8](exp)
        let publickey = RSAEncryption.RSAEnc.EncodedData(modulusData: modulusData,exp1: exponentData)
        // Do any additional setup after loading the view.
        let data = RSAEncryption.encrypt(string:DataToEncrypt,publicKey:publickey)
        return data ?? ""
    }
    
}
//MARK:- Extension for XML Parsing
extension RSAViewController : XMLParserDelegate{
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "RSAKeyValue" {
            modulus = String()
            exponent = String()
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "RSAKeyValue" {
            let rsaComponent = RSAComponent.init(modulus: modulus, exponent: exponent)
            rsaComponents.append(rsaComponent)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.elementName == "Modulus" {
                modulus += data
            } else if self.elementName == "Exponent" {
                exponent += data
            }
        }
    }
}

//MARK:- struct for Parsing
struct RSAComponent {
    var modulus: String
    var exponent: String
}
