//
//  AESHelper.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 23/01/23.
//

import Foundation
import CommonCrypto
import UIKit

/// This Struct Contains AES Encryption and Decryption using IV and Key Provided
struct AES {

    // MARK: - Value
    // MARK: Private
    private let key: Data
    private let initializationVectorIV: Data

    // MARK: - Initialzier
    init?(key: String, initializationVectorIV: String) {
        guard key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256,
                let keyData = key.data(using: .utf8)
        else {
            debugPrint("Error: Failed to set a key.")
            return nil
        }

        guard initializationVectorIV.count == kCCBlockSizeAES128,
                let ivData = initializationVectorIV.data(using: .utf8)
        else {
            debugPrint("Error: Failed to set an initial vector.")
            return nil
        }

        self.key = keyData
        self.initializationVectorIV  = ivData
    }

    // MARK: - Function

    /// Function Call to encrypt Plain Text to AES
    /// - Parameter string: Plain text
    /// - Returns: Data
    func encrypt(string: String) -> Data? {
        return crypt(data: string.data(using: .utf8), option: CCOperation(kCCEncrypt))
    }

    func decrypt(data: Data?) -> String? {
        guard let decryptedData = crypt(data: data, option: CCOperation(kCCDecrypt)) else { return nil }
        return String(bytes: decryptedData, encoding: .utf8)
    }

    fileprivate func crypt(data: Data?, option: CCOperation) -> Data? {
        guard let data = data else { return nil }

        let cryptLength = data.count + kCCBlockSizeAES128
        var cryptData   = Data(count: cryptLength)

        let keyLength = key.count
        let options   = CCOptions(kCCOptionPKCS7Padding)

        var bytesLength = Int(0)

        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                initializationVectorIV.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                    CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), options, keyBytes.baseAddress,
                            keyLength, ivBytes.baseAddress, dataBytes.baseAddress,
                            data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
                    }
                }
            }
        }

        guard UInt32(status) == UInt32(kCCSuccess) else {
            debugPrint("Error: Failed to crypt data. Status \(status)")
            return nil
        }

        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return cryptData
    }
}
