//
//  Genres.swift
//  Music
//
//  Created by QuangHo on 17/07/2022.
//

import Foundation
struct GenresModel:Codable {
    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let genres = try? newJSONDecoder().decode(Genres.self, from: jsonData)

    // MARK: - Genres
    struct Genres: Codable {
        let data: [Datum]
    }

    // MARK: - Datum
    struct Datum: Codable, Hashable, Identifiable {
        static func == (lhs: GenresModel.Datum, rhs: GenresModel.Datum) -> Bool {
            return true
        }
        
        func hash(into hasher: inout Hasher) {
            
        }
        
        let id: String
        let type: TypeEnum
        let href: String
        let attributes: Attributes
    }

    // MARK: - Attributes
    struct Attributes: Codable {
        let name: String
        let parentName: ParentName?
        let parentID: String?

        enum CodingKeys: String, CodingKey {
            case name, parentName
            case parentID = "parentId"
        }
    }

    enum ParentName: String, Codable {
        case indian = "Indian"
        case music = "Music"
        case pop = "Pop"
        case regionalIndian = "Regional Indian"
    }

    enum TypeEnum: String, Codable {
        case genres = "genres"
    }

}
