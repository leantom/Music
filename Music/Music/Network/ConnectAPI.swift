//
//  ConnectAPI.swift
//  Music
//
//  Created by QuangHo on 27/06/2022.
//

import Foundation
import StoreKit
import MusicKit

enum TypeSectionHome: String {
    case chart = "chart"
    case artist = "artist"
    case playlist = "playlist"
    case genres = "genres"
    case album = "album"
    case search = "search"
}

class Network: NSObject {
    
    static let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IlA1Mjc4UFY3MjQifQ.eyJpc3MiOiI5NzhQSzROWkZMIiwiZXhwIjoxNjYxNDg0NDk0LCJpYXQiOjE2NjE0NDEyOTR9.CBR2gFMKu2WAUQnXlOgLKZ-OIrk61Bx_7iHGxfbyZ8xndaRpgt1P1GgxPnsKS8wzdhMGdzNt5rq1fZxSfj1pmQ"
    
    func start() async throws -> ChartResults? {
        
        let authorization = await SKCloudServiceController.requestAuthorization()
        
        
        switch authorization {
        case .denied, .restricted:
            return nil
        case .authorized:
            return try await enableAppleMusicBasedFeatures()
        default: break
        }
        return nil
    }
    
    func enableAppleMusicBasedFeatures() async throws -> ChartResults? {
        let controller = SKCloudServiceController()
        let error = try await controller.requestUserToken(forDeveloperToken: Network.token)
        if error.isEmpty == false {
            return try await getDataHome(type: .chart)
        }
        return nil
    }
    
    
    func getGenres() async throws -> [GenresModel.Datum] {
        
        guard let data = try await getData(type: .genres) else {return []}
        
        do {
            
            let welcome = try JSONDecoder().decode(GenresModel.Genres.self, from: data)
            print(welcome.data.count)
            return welcome.data
            
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
    
     func disableAppleMusicBasedFeatures() {
        print("denied")
    }
    
    func getDataHome(type: TypeSectionHome) async throws -> ChartResults? {
        let countryCode = "vn"
        
        var components = URLComponents()
        components.scheme = "https"
        components.host   = "api.music.apple.com"
        switch type {
        case .chart:
            components.path   = "/v1/catalog/\(countryCode)/charts"
        case .artist:
            components.path   = "/v1/catalog/vn/artists?ids=1492507625,320647796,705007874,320110262,384038714,320680503,1156866299,1065981054,159260351,890403665"
        case .playlist:
            components.path   = "/v1/catalog/\(countryCode)/playlists"
        case .genres:
            components.path   = "/v1/catalog/\(countryCode)/genres"
        case .album:
            components.path   = "/v1/catalog/us/albums"
        default:break
        }
        
        if type == .chart {
            components.queryItems = [
                URLQueryItem(name: "types", value: "songs,albums,playlists"),
                URLQueryItem(name: "limit", value: "40"),
            ]
        }
        
        
        guard let url = components.url else {return nil}
        var request = URLRequest(url: url)
        request.setValue("Bearer \(Network.token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        
        let (data, _) = try await session.data(for: request)
        
        do {
            
            let welcome = try JSONDecoder().decode(Chart.self, from: data)
            
            return welcome.results
            
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
        return nil
    }
    
    func getPlaylist() async throws -> PlaylistModel.Playlist? {
        let countryCode = "vn"
        
        var components = URLComponents()
        components.scheme = "https"
        components.host   = "api.music.apple.com"
        
        components.path   = "/v1/catalog/\(countryCode)/playlists"
        
        components.queryItems = [
            URLQueryItem(name: "types", value: "songs,albums,playlists"),
            URLQueryItem(name: "limit", value: "40"),
        ]
        
        guard let url = components.url else {return nil}
        var request = URLRequest(url: url)
        request.setValue("Bearer \(Network.token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        
        let (data, _) = try await session.data(for: request)
        
        do {
            let welcome = try JSONDecoder().decode(PlaylistModel.Playlist.self, from: data)
            
            return welcome
            
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
        return nil
    }
    
    func getData(type: TypeSectionHome, ids: String = "") async throws -> Data? {
        let countryCode = "vn"
        
        var components = URLComponents()
        components.scheme = "https"
        components.host   = "api.music.apple.com"
        switch type {
        case .chart:
            components.path   = "/v1/catalog/\(countryCode)/charts"
        case .artist:
            components.path   = "/v1/catalog/vn/artists"
        case .playlist:
            components.path   = "/v1/catalog/\(countryCode)/playlists"
        case .genres:
            components.path   = "/v1/catalog/\(countryCode)/genres"
        case .album:
            components.path   = "/v1/catalog/\(countryCode)/albums"
        case .search:
            components.path   = "/v1/catalog/\(countryCode)/search"
        }
        if type == .chart {
            components.queryItems = [
                URLQueryItem(name: "types", value: "songs,albums,playlists"),
                URLQueryItem(name: "limit", value: "40"),
            ]
        } else if type == .artist {
            components.queryItems = [
                URLQueryItem(name: "ids", value: "1492507625,320647796,705007874,320110262,384038714,320680503,1156866299,1065981054,159260351,890403665"),
            ]
        } else if type == .album {
            components.queryItems = [
                URLQueryItem(name: "ids", value: ids),
            ]
        } else if type == .search {
            components.queryItems = [
                URLQueryItem(name: "types", value: "songs"),
                URLQueryItem(name: "limit", value: "20"),
                URLQueryItem(name: "term", value: ids),
            ]
        }
        
        guard let url = components.url else {return nil}
        var request = URLRequest(url: url)
        request.setValue("Bearer \(Network.token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let (data, _) = try await session.data(for: request)
        
        return data
    }
    
}
