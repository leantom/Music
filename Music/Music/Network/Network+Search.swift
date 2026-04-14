//
//  Network+Search.swift
//  Music
//
//  Created by QuangHo on 31/07/2022.
//

import Foundation
extension Network {
    func search(text: String) async throws -> [Datum] {
        
        guard let data = try await getData(type: .search, ids: text) else {return []}
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(json)
            }
            let welcome = try JSONDecoder().decode(Catalog.self, from: data)
            print(welcome.results.songs.data.count)
            return welcome.results.songs.data
            
        } catch let DecodingError.dataCorrupted(context) {
            print("corrupted data \(context)")
            
            
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: \(context.debugDescription)")
            print("codingPath: \(context.codingPath)")
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)

        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        catch let err {
            print(err.localizedDescription)
        }
        return []
    }
}
