//
//  Network+Album.swift
//  Music
//
//  Created by QuangHo on 31/07/2022.
//

import Foundation
extension Network {
    func getArtist() async throws -> [ArtistModel.ArtistDatum]   {
        guard let data = try await getData(type: .artist) else {return []}
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(json)
            }
            
            
            let welcome = try JSONDecoder().decode(ArtistModel.Artist.self, from: data)
            return welcome.data
        }catch let DecodingError.dataCorrupted(context) {
            print("corrupted data \(context)")
            
            
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: \(context.debugDescription)")
            print("codingPath: \(context.codingPath)")
            print("underlyingError: \(context.underlyingError?.localizedDescription)")
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
    
    func getSongFromAlbums(ids: String) async throws -> [AlbumModel.AlbumDatum] {
        guard let data = try await getData(type: .album, ids: ids) else {return []}
       
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(json)
            }
            
            let welcome = try JSONDecoder().decode(AlbumModel.Album.self, from: data)
            return welcome.data
        }catch let DecodingError.dataCorrupted(context) {
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
