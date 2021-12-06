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
    
    // MARK: - AES Encryption
    
    // MARK: - SHA Encryption
    
}
