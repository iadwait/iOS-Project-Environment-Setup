//
//  CurrencyDataModel.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 28/09/21.
//

import Foundation

// CurrencyDataModel is Data Model for this api "https://api.coindesk.com/v1/bpi/currentprice.json"
struct CurrencyDataModel : Codable {
    let time : Time?
    let disclaimer : String?
    let chartName : String?
    let bpi : Bpi?

    enum CodingKeys: String, CodingKey {

        case time = "time"
        case disclaimer = "disclaimer"
        case chartName = "chartName"
        case bpi = "bpi"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        time = try values.decodeIfPresent(Time.self, forKey: .time)
        disclaimer = try values.decodeIfPresent(String.self, forKey: .disclaimer)
        chartName = try values.decodeIfPresent(String.self, forKey: .chartName)
        bpi = try values.decodeIfPresent(Bpi.self, forKey: .bpi)
    }

}

struct Time : Codable {
    let updated : String?
    let updatedISO : String?
    let updateduk : String?

    enum CodingKeys: String, CodingKey {

        case updated = "updated"
        case updatedISO = "updatedISO"
        case updateduk = "updateduk"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        updatedISO = try values.decodeIfPresent(String.self, forKey: .updatedISO)
        updateduk = try values.decodeIfPresent(String.self, forKey: .updateduk)
    }

}

struct Bpi : Codable {
    let uSD : USD?
    let gBP : GBP?
    let eUR : EUR?

    enum CodingKeys: String, CodingKey {

        case uSD = "USD"
        case gBP = "GBP"
        case eUR = "EUR"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uSD = try values.decodeIfPresent(USD.self, forKey: .uSD)
        gBP = try values.decodeIfPresent(GBP.self, forKey: .gBP)
        eUR = try values.decodeIfPresent(EUR.self, forKey: .eUR)
    }

}

struct EUR : Codable {
    let code : String?
    let symbol : String?
    let rate : String?
    let description : String?
    let rate_float : Double?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case symbol = "symbol"
        case rate = "rate"
        case description = "description"
        case rate_float = "rate_float"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        rate_float = try values.decodeIfPresent(Double.self, forKey: .rate_float)
    }

}

struct GBP : Codable {
    let code : String?
    let symbol : String?
    let rate : String?
    let description : String?
    let rate_float : Double?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case symbol = "symbol"
        case rate = "rate"
        case description = "description"
        case rate_float = "rate_float"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        rate_float = try values.decodeIfPresent(Double.self, forKey: .rate_float)
    }

}

struct USD : Codable {
    let code : String?
    let symbol : String?
    let rate : String?
    let description : String?
    let rate_float : Double?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case symbol = "symbol"
        case rate = "rate"
        case description = "description"
        case rate_float = "rate_float"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        rate_float = try values.decodeIfPresent(Double.self, forKey: .rate_float)
    }

}
