// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let chart = try? newJSONDecoder().decode(Chart.self, from: jsonData)

import Foundation

// MARK: - Chart
struct Chart: Codable {
    let results: ChartResults
    let meta: Meta
}

// MARK: - Meta
struct Meta: Codable {
    let results: MetaResults
}

// MARK: - MetaResults
struct MetaResults: Codable {
    let order: [String]
}

// MARK: - ChartResults
struct ChartResults: Codable {
    let songs, playlists, albums: [Album]
}

// MARK: - Album
struct Album: Codable, Hashable, Identifiable {
    var id: ObjectIdentifier?
    
    let chart, name, orderID: String
    let next: String?
    let data: [Datum]
    let href: String

    enum CodingKeys: String, CodingKey {
        case chart, name
        case orderID = "orderId"
        case next, data, href
    }
}


// MARK: - Artwork
struct Artwork: Codable {
    let width, height: Int
    let url, bgColor, textColor1, textColor2: String?
    let textColor3, textColor4: String?
}

// MARK: - EditorialNotes
struct EditorialNotes: Codable {
    let standard, short: String
}

// MARK: - PlayParams
struct PlayParams: Codable {
    let id, kind: String
}

// MARK: - Preview
struct Preview: Codable {
    let url: String
}
