//
//  PlaylistModel.swift
//  Music
//
//  Created by QuangHo on 17/07/2022.
//

import Foundation
struct PlaylistModel {
    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let playlist = try? newJSONDecoder().decode(Playlist.self, from: jsonData)

    

    // MARK: - Playlist
    struct Playlist: Codable {
        let data: [Datum]
        let meta: Meta
    }

    // MARK: - Datum
    struct Datum: Codable {
        let id, type, href: String
        let attributes: PurpleAttributes
        let relationships: Relationships
    }

    // MARK: - PurpleAttributes
    struct PurpleAttributes: Codable {
        let artwork: Artwork
        let isChart: Bool
        let url: String
        let lastModifiedDate: Date
        let name, playlistType, curatorName: String
        let playParams: PurplePlayParams
        let attributesDescription: Description

        enum CodingKeys: String, CodingKey {
            case artwork, isChart, url, lastModifiedDate, name, playlistType, curatorName, playParams
            case attributesDescription = "description"
        }
    }

    // MARK: - Artwork
    struct Artwork: Codable {
        let width, height: Int
        let url, bgColor, textColor1, textColor2: String
        let textColor3, textColor4: String
    }

    // MARK: - Description
    struct Description: Codable {
        let standard: String
    }

    // MARK: - PurplePlayParams
    struct PurplePlayParams: Codable {
        let id, kind, versionHash: String
    }

    // MARK: - Relationships
    struct Relationships: Codable {
        let tracks, curator: Curator
    }

    // MARK: - Curator
    struct Curator: Codable {
        let href: String
        let data: [Me]
    }

    // MARK: - Me
    struct Me: Codable {
        let id, type, href: String
        let attributes: MeAttributes?
    }

    // MARK: - MeAttributes
    struct MeAttributes: Codable {
        let previews: [Preview]
        let artwork: Artwork
        let artistName: String
        let url: String
        let discNumber: Int
        let genreNames: [String]
        let durationInMillis: Int
        let releaseDate: String
        let isAppleDigitalMaster: Bool
        let name, isrc: String
        let hasLyrics: Bool
        let albumName: String
        let playParams: FluffyPlayParams
        let trackNumber: Int
        let composerName, contentRating: String
    }

    // MARK: - FluffyPlayParams
    struct FluffyPlayParams: Codable {
        let id, kind: String
    }

    // MARK: - Preview
    struct Preview: Codable {
        let url: String
    }

    // MARK: - Meta
    struct Meta: Codable {
        let filters: Filters
    }

    // MARK: - Filters
    struct Filters: Codable {
        let storefrontChart: StorefrontChart

        enum CodingKeys: String, CodingKey {
            case storefrontChart = "storefront-chart"
        }
    }

    // MARK: - StorefrontChart
    struct StorefrontChart: Codable {
        let us: [Me]
    }

}
