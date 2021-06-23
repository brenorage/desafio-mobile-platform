//
//  Ad.swift
//  desafio
//
//  Created by Fernando Luiz Goulart on 13/04/21.
//

import Foundation

struct ListAds: Decodable {
    let list_ads: [Ad]?
}

struct Ad: Decodable {
    let adDetail: AdDetail

    enum CodingKeys: String, CodingKey {
        case adDetail = "ad"
    }
}

struct AdDetail: Decodable {
    let subject: String
    let thumbnail: AdThumbnail?
    let prices: [AdPrice]?
    let locations: [AdLocation]
    let list_time: AdListTime

    func getNeighbourhoodLocation(at locations: [AdLocation]) -> AdLocation? {
        for loc in locations {
            if loc.key == "neighbourhood" {
                return loc
            } else if let unwrapedLoc = loc.locations {
                return getNeighbourhoodLocation(at: unwrapedLoc)
            }
        }

        return nil
    }
}

struct AdThumbnail: Decodable {
    let height: Int
    let width: Int
    let path: String
    let base_url: String
    let media_id: String
}

struct AdPrice: Decodable {
    let label: String
    let price_value: Int
}

struct AdLocation: Decodable {
    let code: String?
    let key: String?
    let label: String?
    let locations: [AdLocation]?

    enum CodingKeys: String, CodingKey {
        case code, key, label, locations
    }
}

struct AdListTime: Decodable {
    let label: String
    let value: Int

    var formattedTime: String {
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(value))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt-BR")
        dateFormatter.dateFormat = "dd/MM 'às' HH:mm"
        return dateFormatter.string(from: date)
    }
}
