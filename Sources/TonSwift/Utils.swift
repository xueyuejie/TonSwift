//
//  Utils.swift
//  
//
//  Created by 薛跃杰 on 2023/1/3.
//

import Foundation
import CryptoSwift
import TweetNacl

public struct Utils {
    public init() {}
    
    public static func readNBytesFromArray(count: Int, ui8array: [UInt8]) -> Int {
        var res:Int = 0;
        for i in 0 ..< count {
            res *= 256
            res += Int(ui8array[i] & 0xff)
        }
        return res
    }
    
    public static func getCRC32ChecksumAsBytesReversed(data: Data) -> Data {
        let crc32c = Checksum.crc32c(data.bytes)
        let intCrcBytes = withUnsafeBytes(of: crc32c.bigEndian, Array.init)
        return Data(intCrcBytes.reversed())
    }
    
    public static func getCRC16ChecksumAsInt(data: Data) -> Int {
        var crc: Int = 0x0000;
        let polynomial: Int = 0x1021;
        for b in data.bytes {
            for i in 0..<8 {
                let bit = ((b >> (7 - i) & 1) == 1)
                let c15 = ((crc >> 15 & 1) == 1)
                crc = crc << 1
                if (UInt8(c15 ? 1 : 0) ^ UInt8(bit ? 1 : 0)) == UInt8(1) {
                    crc = crc ^ polynomial
                }
            }
        }

        crc = crc & 0xffff
        return crc;
    }

    public static func getCRC16ChecksumAsBytes(data: Data) -> Data {
        let crc16c = getCRC16ChecksumAsInt(data: data)
        return Data(intToByteArray(value: crc16c))
    }
    
    public static func intToByteArray(value: Int) -> [UInt8] {
        var intV = value
        let valueBytes: Data = Data(bytes: &intV, count: 8)
        return [valueBytes[1],valueBytes[0]]
    }
    
    public static func compareBytes(a: [UInt8], b: [UInt8]) -> Bool {
        return a.elementsEqual(b)
    }
    
    public static func signData(prvKey: Data, data: Data) throws -> Data {
         var signature = Data()
         if (prvKey.count == 64) {
             signature = try TweetNacl.NaclSign.signDetached(message: data, secretKey: prvKey)
         } else {
             let keyPair = try TweetNacl.NaclSign.KeyPair.keyPair(fromSecretKey: prvKey)
             signature = try TweetNacl.NaclSign.signDetached(message: data, secretKey: keyPair.secretKey)
         }
         return signature
     }
}
