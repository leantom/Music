// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let catalog = try? newJSONDecoder().decode(Catalog.self, from: jsonData)

import Foundation

// MARK: - Catalog
struct Catalog: Codable {
    let results: CatalogResults
    let meta: Meta
}


// MARK: - CatalogResults
struct CatalogResults: Codable {
    let songs: Songs
}

// MARK: - Songs
struct Songs: Codable {
    let href, next: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable, Hashable, Identifiable {
    static func == (lhs: Datum, rhs: Datum) -> Bool {
        return lhs.href == rhs.href
    }
    func hash(into hasher: inout Hasher) {
        
    }
    
    let id, type, href: String
    let attributes: Attributes
}

// MARK: - Attributes
struct Attributes: Codable {
    let previews: [Preview]?
    let artwork: Artwork
    let artistName: String?
    let url: String
    let discNumber: Int?
    let genreNames: [String]?
    let durationInMillis: Int?
    let releaseDate: String?
    let isAppleDigitalMaster: Bool?
    let name, isrc: String?
    let hasLyrics: Bool?
    let albumName: String?
    let playParams: PlayParams
    let trackNumber: Int?
    let composerName: String?
    let contentRating: String?
    
    var duration: String? {
        guard let durationInMillis = durationInMillis else {
            return nil
        }

        return (durationInMillis/1000).formatToMins()
    }
    
    func getURLArtWork() -> URL? {
        guard let urlStr = artwork.url else { return nil }
        let url = urlStr.replacingOccurrences(of: "{w}x{h}", with: "300x300")
        return URL(string: url)
    }
    
}

