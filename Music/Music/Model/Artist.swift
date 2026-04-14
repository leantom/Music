//
//  Artist.swift
//  Music
//
//  Created by QuangHo on 29/07/2022.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artist = try? newJSONDecoder().decode(Artist.self, from: jsonData)
import Foundation

struct ArtistModel {
    
    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let artist = try? newJSONDecoder().decode(Artist.self, from: jsonData)


    // MARK: - Artist
    struct Artist: Codable {
        let data: [ArtistDatum]
    }

    // MARK: - ArtistDatum
    struct ArtistDatum: Codable,Hashable, Identifiable{
        
        func hash(into hasher: inout Hasher) {
            
        }
        
        static func == (lhs: ArtistModel.ArtistDatum, rhs: ArtistModel.ArtistDatum) -> Bool {
            return lhs.href == rhs.href
        }
        
        let id: String
        let type: FluffyType
        let href: String
        let attributes: Attributes
        let relationships: Relationships
    }

    // MARK: - Attributes
    struct Attributes: Codable {
        let name: String
        let genreNames: [GenreName]
        let url: String
        let artwork: Artwork
        let editorialNotes: EditorialNotes?
        
        func getURLArtWork() -> URL? {
            let url = artwork.url.replacingOccurrences(of: "{w}x{h}", with: "300x300")
            return URL(string: url)
        }
    }

    // MARK: - Artwork
    struct Artwork: Codable {
        let width, height: Int
        let url, bgColor, textColor1, textColor2: String
        let textColor3, textColor4: String
    }

    // MARK: - EditorialNotes
    struct EditorialNotes: Codable {
        let short: String
    }

    enum GenreName: String, Codable {
        case alternative = "Alternative"
        case pop = "Pop"
    }

    // MARK: - Relationships
    struct Relationships: Codable {
        let albums: Albums
    }

    // MARK: - Albums
    struct Albums: Codable {
        let href, next: String
        let data: [AlbumsDatum]?
    }

    // MARK: - AlbumsDatum
    struct AlbumsDatum: Codable {
        let id: String
        let type: PurpleType
        let href: String
    }

    enum PurpleType: String, Codable {
        case albums = "albums"
    }

    enum FluffyType: String, Codable {
        case artists = "artists"
    }

}
