//
//  RSAEncryption.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 06/12/21.
//  Copyright - Aman Gangurde (Winjit Technologies)

import Foundation
import Security

///class to achieve RSA encryption decryption
public class RSAEncryption {
    public static let RSAEnc = RSAEncryption()
    
    /// Generate a secKey for encryption using modulus and exponent
    public func EncodedData(modulusData: [UInt8],exp1: [UInt8]) -> SecKey
    {
        var modulus = modulusData
        
        let exponent = exp1
        // example values - insert your modulus and exponent here
        
        // prefix with 0x00 to indicate that it is a non-negative number
        modulus.insert(0x00, at: 0)
        
        // encode the modulus and exponent as INTEGERs
        var modulusEncoded: [UInt8] = [0x02]
        modulusEncoded.append(contentsOf: lengthField(of: modulus))
        modulusEncoded.append(contentsOf: modulus)
        
        var exponentEncoded: [UInt8] = [0x02]
        exponentEncoded.append(contentsOf: lengthField(of: exponent))
        exponentEncoded.append(contentsOf: exponent)
        
        // combine these INTEGERs to a SEQUENCE
        var sequenceEncoded: [UInt8] = [0x30]
        sequenceEncoded.append(contentsOf: lengthField(of: (modulusEncoded + exponentEncoded)))
        sequenceEncoded.append(contentsOf: (modulusEncoded + exponentEncoded))
        
        // all done, we now have the PKCS#1 key
        let keyData = Data(sequenceEncoded)
        
        // let's check it actully works...
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
            kSecAttrKeySizeInBits as String: modulus.count * 8
        ]
        
        var error: Unmanaged<CFError>?
        let publicKey = SecKeyCreateWithData(keyData as CFData, attributes as CFDictionary, &error)
        
        return publicKey ?? 0 as! SecKey
        
    }
    
    /// Generate a lenght feild
    public func lengthField(of valueField: [UInt8]) -> [UInt8] {
        var count = valueField.count
        
        if count < 128 {
            return [ UInt8(count) ]
        }
        
        // The number of bytes needed to encode count.
        let lengthBytesCount = Int((log2(Double(count)) / 8) + 1)
        
        // The first byte in the length field encoding the number of remaining bytes.
        let firstLengthFieldByte = UInt8(128 + lengthBytesCount)
        
        var lengthField: [UInt8] = []
        for _ in 0..<lengthBytesCount {
            // Take the last 8 bits of count.
            let lengthByte = UInt8(count & 0xff)
            // Add them to the length field.
            lengthField.insert(lengthByte, at: 0)
            // Delete the last 8 bits of count.
            count = count >> 8
        }
        
        // Include the first byte.
        lengthField.insert(firstLengthFieldByte, at: 0)
        
        return lengthField
        
    }
    
    /// data using  generated publickey  and data to encrypt
    public static func encrypt(string: String, publicKey: SecKey) -> String? {
        let buffer = [UInt8](string.utf8)
        
        var keySize   = SecKeyGetBlockSize(publicKey)
        var keyBuffer = [UInt8](repeating: 0, count: keySize)
        
        // Encrypto  should less than key length
        guard SecKeyEncrypt(publicKey, SecPadding.PKCS1, buffer, buffer.count, &keyBuffer, &keySize) == errSecSuccess else { return nil }
        return Data(bytes: keyBuffer, count: keySize).base64EncodedString()
    }
    
    
    
    
}
