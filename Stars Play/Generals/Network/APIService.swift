////
////  APIService.swift
////  Stars Play
////
////  Created by Asif Ayub on 16/02/2025.
////
//
//
//import Foundation
//import Alamofire
//
//class APIService {
//    static let shared = APIService()
//    private let apiKey = "ecef14eac236a5d4ec6ac3a4a4761e8f"
//    private let baseURL = "https://api.themoviedb.org/3"
//
//    // Fetch TV show details
//    func fetchTVShowDetails(showId: Int) async throws -> TVShow {
//        let url = "\(baseURL)/tv/\(showId)?api_key=\(apiKey)"
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            AF.request(url).responseData { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let show = try JSONDecoder().decode(TVShow.self, from: data)
//                        continuation.resume(returning: show)
//                    } catch {
//                        continuation.resume(throwing: error)
//                    }
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//
//    // Fetch popular TV shows list
//    func fetchTVShowsList() async throws -> TVShowsListDetail {
//        let url = "\(baseURL)/tv/popular?api_key=\(apiKey)"
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            AF.request(url).responseData { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let shows = try JSONDecoder().decode(TVShowsListDetail.self, from: data)
//                        continuation.resume(returning: shows)
//                    } catch {
//                        continuation.resume(throwing: error)
//                    }
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//
//    // Fetch season details
//    func fetchSeasonDetails(showId: Int, seasonNumber: Int) async throws -> [Episode] {
//        let url = "\(baseURL)/tv/\(showId)/season/\(seasonNumber)?api_key=\(apiKey)"
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            AF.request(url).responseData { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let season = try JSONDecoder().decode(SeasonDetail.self, from: data)
//                        continuation.resume(returning: season.episodes ?? [])
//                    } catch {
//                        continuation.resume(throwing: error)
//                    }
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//}
