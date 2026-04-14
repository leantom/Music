//
//  Album.swift
//  Music
//
//  Created by QuangHo on 30/07/2022.
//

import Foundation
struct AlbumModel {
    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let album = try? newJSONDecoder().decode(Album.self, from: jsonData)


    // MARK: - Album
    struct Album: Codable {
        let data: [AlbumDatum]
    }

    // MARK: - AlbumDatum
    struct AlbumDatum: Codable {
        let id, type, href: String
        let attributes: PurpleAttributes
        let relationships: Relationships?
    }

    // MARK: - PurpleAttributes
    struct PurpleAttributes: Codable {
        let artwork: Artwork
        let artistName: String
        let isSingle: Bool
        let url: String
        let isComplete: Bool
        let genreNames: [String]
        let trackCount: Int
        let isMasteredForItunes: Bool
        let releaseDate, name, recordLabel, upc: String
        let copyright: String
        let playParams: PlayParams?
        let isCompilation: Bool
        func getURLArtWork() -> URL? {
            let url = url.replacingOccurrences(of: "{w}x{h}", with: "300x300")
            return URL(string: url)
        }
    }

    // MARK: - Artwork
    struct Artwork: Codable {
        let width, height: Int
        let url, bgColor, textColor1, textColor2: String
        let textColor3, textColor4: String
    }

    // MARK: - PlayParams
    struct PlayParams: Codable {
        let id, kind: String
    }

    // MARK: - Relationships
    struct Relationships: Codable {
        let tracks: Artists?
        let artists: Artists
    }

    // MARK: - Artists
    struct Artists: Codable {
        let href: String
        let data: [ArtistsDatum]
        
    }

    // MARK: - ArtistsDatum
    struct ArtistsDatum: Codable,Identifiable {
        let id, type, href: String
        let attributes: Attributes?
    }
}
