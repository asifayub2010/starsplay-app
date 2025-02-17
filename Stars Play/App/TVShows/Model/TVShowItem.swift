//
//  TVShowItem.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//


import Foundation
import SwiftyJSON

struct TVShowsListDetail: Codable {
    let results: [TVShowItem]
}

struct TVShowItem: Codable, Identifiable {
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let firstAirDate: String
    let name: String
    let voteAverage: Double
    let voteCount: Int
    
    // CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


// Function to parse SwiftyJSON to TVShowsListDetail
func parseTVShowsListDetail(from json: JSON) -> TVShowsListDetail? {
    do {
        let jsonData = try json.rawData()
        let decoder = JSONDecoder()
        let tvShowsListDetail = try decoder.decode(TVShowsListDetail.self, from: jsonData)
        return tvShowsListDetail
    } catch {
        print("Error parsing JSON: \(error)")
        return nil
    }
}
