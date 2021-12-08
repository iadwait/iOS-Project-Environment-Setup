//
//  EncryptionHelper.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 06/12/21.
//

import Foundation

/// This Class will contain all types of Encryption Methods
class EncryptionHelper {
    
    // MARK: - RSA Encryption
    
    /// Function call to perform RSA Encryption when Public key given is directly formed using Modulo and Exponent
    /// - Parameters:
    ///   - string: Data to Encrypt
    ///   - publicKey: Public Key in String Format
    /// - Returns: Encrypted Text
    static func encryptRSA(string: String, publicKey: String?) -> String? {
        guard let publicKey = publicKey else { return nil }
        
        let keyString = publicKey.replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----\n", with: "").replacingOccurrences(of: "\n-----END PUBLIC KEY-----", with: "")
        guard let data = Data(base64Encoded: keyString) else { return nil }
        
        var attributes: CFDictionary {
            return [kSecAttrKeyType         : kSecAttrKeyTypeRSA,
                    kSecAttrKeyClass        : kSecAttrKeyClassPublic,
                    kSecAttrKeySizeInBits   : 2048,
                    kSecReturnPersistentRef : kCFBooleanTrue] as CFDictionary
        }
        
        var error: Unmanaged<CFError>? = nil
        guard let secKey = SecKeyCreateWithData(data as CFData, attributes, &error) else {
            print(error.debugDescription)
            return nil
        }
        return encryptRSA(string: string, publicKey: secKey)
    }
    
    /// Function call to encrypt Data using RSA Encryption
    /// - Parameters:
    ///   - string: Data to Encrypt
    ///   - publicKey: public key of type SecKey
    /// - Returns: Encrypted Data
    static func encryptRSA(string: String, publicKey: SecKey) -> String? {
        let buffer = [UInt8](string.utf8)
        
        var keySize   = SecKeyGetBlockSize(publicKey)
        var keyBuffer = [UInt8](repeating: 0, count: keySize)
        
        // Encrypto  should less than key length
        guard SecKeyEncrypt(publicKey, SecPadding.PKCS1, buffer, buffer.count, &keyBuffer, &keySize) == errSecSuccess else { return nil }
        return Data(bytes: keyBuffer, count: keySize).base64EncodedString()
    }
    
    /// Function call when RSA Encryption need's to be done, & Key need's to be formed using Modulo and Exponenent
    /// - Parameters:
    ///   - DataToEncrypt: Data to Encrypt
    ///   - RSAKey: Base 64 Encoded Key that Contain Modulo and Exponent
    /// - Returns: Encypted RSA Text
    static func encryptRSA_Base64EncodedKey(DataToEncrypt:String,RSAKey : String) -> String {
        let vc =  RSAViewController()
        let EncryptedData = vc.getRSAEncryptedData(DataToEncrypt: DataToEncrypt, RSAKey: RSAKey)
        return EncryptedData
    }
    
    // MARK: - AES Encryption
    
    // MARK: - SHA Encryption
    
    /// Function Call to encrypt Data using SHA Algorithm
    /// - Parameters:
    ///   - input: Data to Encrypt
    ///   - type: Algorithm Type
    /// - Returns: Encrypted String
    func encryptSHA(input: String,type: SHAType) -> String {
        var encryptedString = ""
        
        // SHA 256
        if type == .SHA256 {
            encryptedString = input.sha256()
        }
        
        // SHA 192
        if type == .SHA192 {
            
        }
        
        return encryptedString
    }
    
}
