//
//  CovidDataModel.swift
//  Project Setup Demo
//
//  Created by Adwait Barkale on 03/12/21.
//

import Foundation

struct CovidDataModel : Codable {
    let date : Int?
    let states : Int?
    let positive : Int?
    let negative : Int?
    let pending : Int?
    let hospitalizedCurrently : Int?
    let hospitalizedCumulative : Int?
    let inIcuCurrently : Int?
    let inIcuCumulative : Int?
    let onVentilatorCurrently : Int?
    let onVentilatorCumulative : Int?
    let dateChecked : String?
    let death : Int?
    let hospitalized : Int?
    let totalTestResults : Int?
    let lastModified : String?
    let recovered : String?
    let total : Int?
    let posNeg : Int?
    let deathIncrease : Int?
    let hospitalizedIncrease : Int?
    let negativeIncrease : Int?
    let positiveIncrease : Int?
    let totalTestResultsIncrease : Int?
    let hash : String?

    enum CodingKeys: String, CodingKey {

        case date = "date"
        case states = "states"
        case positive = "positive"
        case negative = "negative"
        case pending = "pending"
        case hospitalizedCurrently = "hospitalizedCurrently"
        case hospitalizedCumulative = "hospitalizedCumulative"
        case inIcuCurrently = "inIcuCurrently"
        case inIcuCumulative = "inIcuCumulative"
        case onVentilatorCurrently = "onVentilatorCurrently"
        case onVentilatorCumulative = "onVentilatorCumulative"
        case dateChecked = "dateChecked"
        case death = "death"
        case hospitalized = "hospitalized"
        case totalTestResults = "totalTestResults"
        case lastModified = "lastModified"
        case recovered = "recovered"
        case total = "total"
        case posNeg = "posNeg"
        case deathIncrease = "deathIncrease"
        case hospitalizedIncrease = "hospitalizedIncrease"
        case negativeIncrease = "negativeIncrease"
        case positiveIncrease = "positiveIncrease"
        case totalTestResultsIncrease = "totalTestResultsIncrease"
        case hash = "hash"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(Int.self, forKey: .date)
        states = try values.decodeIfPresent(Int.self, forKey: .states)
        positive = try values.decodeIfPresent(Int.self, forKey: .positive)
        negative = try values.decodeIfPresent(Int.self, forKey: .negative)
        pending = try values.decodeIfPresent(Int.self, forKey: .pending)
        hospitalizedCurrently = try values.decodeIfPresent(Int.self, forKey: .hospitalizedCurrently)
        hospitalizedCumulative = try values.decodeIfPresent(Int.self, forKey: .hospitalizedCumulative)
        inIcuCurrently = try values.decodeIfPresent(Int.self, forKey: .inIcuCurrently)
        inIcuCumulative = try values.decodeIfPresent(Int.self, forKey: .inIcuCumulative)
        onVentilatorCurrently = try values.decodeIfPresent(Int.self, forKey: .onVentilatorCurrently)
        onVentilatorCumulative = try values.decodeIfPresent(Int.self, forKey: .onVentilatorCumulative)
        dateChecked = try values.decodeIfPresent(String.self, forKey: .dateChecked)
        death = try values.decodeIfPresent(Int.self, forKey: .death)
        hospitalized = try values.decodeIfPresent(Int.self, forKey: .hospitalized)
        totalTestResults = try values.decodeIfPresent(Int.self, forKey: .totalTestResults)
        lastModified = try values.decodeIfPresent(String.self, forKey: .lastModified)
        recovered = try values.decodeIfPresent(String.self, forKey: .recovered)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        posNeg = try values.decodeIfPresent(Int.self, forKey: .posNeg)
        deathIncrease = try values.decodeIfPresent(Int.self, forKey: .deathIncrease)
        hospitalizedIncrease = try values.decodeIfPresent(Int.self, forKey: .hospitalizedIncrease)
        negativeIncrease = try values.decodeIfPresent(Int.self, forKey: .negativeIncrease)
        positiveIncrease = try values.decodeIfPresent(Int.self, forKey: .positiveIncrease)
        totalTestResultsIncrease = try values.decodeIfPresent(Int.self, forKey: .totalTestResultsIncrease)
        hash = try values.decodeIfPresent(String.self, forKey: .hash)
    }

}
