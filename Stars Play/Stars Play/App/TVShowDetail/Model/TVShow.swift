//
//  TVShow.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//


import Foundation
import SwiftyJSON

// MARK: - TVShow Model
struct TVShow: Codable {
    let backdropPath: String?
    let firstAirDate: String
    let id: Int
    let lastAirDate: String
    let name: String
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let originalName: String
    let overview: String
    let posterPath: String?
    var seasons: [SeasonDetail]
    let voteAverage: Double
    let voteCount: Int

    // CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case id
        case lastAirDate = "last_air_date"
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case seasons
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - SeasonDetail Model
struct SeasonDetail: Codable {
    let airDate: String?
    var episodes: [Episode]?
//    let crew: [CrewMember]
//    let guestStars: [GuestStar]
    let name: String?
    let overview: String?
    let seasonId: Int? 
    let posterPath: String?
    let seasonNumber: Int?
    let voteAverage: Double?

    // CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodes
        case name
        case overview
        case seasonId = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

// MARK: - Episode Model
struct Episode: Codable, Identifiable, Hashable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let airDate: String?
    let episodeNumber: Int
    let id: Int
    let name: String
    let overview: String
    let seasonNumber: Int
    let showId: Int
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    // CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id
        case name
        case overview
        case seasonNumber = "season_number"
        case showId = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// Function to parse SwiftyJSON to TVShow
func parseTVShow(from json: JSON) -> TVShow? {
    do {
        let jsonData = try json.rawData()
        let decoder = JSONDecoder()
        let tvShow = try decoder.decode(TVShow.self, from: jsonData)
        return tvShow
    } catch {
        print("Error parsing TV Show JSON: \(error)")
        return nil
    }
}

// Function to parse SwiftyJSON to SeasonDetail
func parseSeasonDetail(from json: JSON) -> SeasonDetail? {
    do {
        let jsonData = try json.rawData()
        let decoder = JSONDecoder()
        let seasonDetail = try decoder.decode(SeasonDetail.self, from: jsonData)
        return seasonDetail
    } catch {
        print("Error parsing Season Detail JSON: \(error)")
        return nil
    }
}

// Function to parse SwiftyJSON to Episode
func parseEpisode(from json: JSON) -> Episode? {
    do {
        let jsonData = try json.rawData()
        let decoder = JSONDecoder()
        let episode = try decoder.decode(Episode.self, from: jsonData)
        return episode
    } catch {
        print("Error parsing Episode JSON: \(error)")
        return nil
    }
}

// Function to parse SwiftyJSON to TVShow with nested SeasonDetails and Episodes
func parseTVShowWithSeasons(from json: JSON) -> TVShow? {
    do {
        // Decode TVShow
        let jsonData = try json.rawData()
        let decoder = JSONDecoder()
        var tvShow = try decoder.decode(TVShow.self, from: jsonData)
        
        // Parse seasons
        var seasons: [SeasonDetail] = []
        for seasonJson in json["seasons"].arrayValue {
            if let seasonDetail = parseSeasonDetail(from: seasonJson) {
                seasons.append(seasonDetail)
            }
        }
        tvShow.seasons = seasons
        
        return tvShow
    } catch {
        print("Error parsing TV Show with Seasons JSON: \(error)")
        return nil
    }
}

//// MARK: - CrewMember Model
//struct CrewMember: Codable {
//    let job: String
//    let department: String
//    let creditId: String
//    let adult: Bool
//    let gender: Int
//    let id: Int
//    let knownForDepartment: String
//    let name: String
//    let originalName: String
//    let popularity: Double
//    let profilePath: String?
//
//    // CodingKeys to map JSON keys to Swift property names
//    enum CodingKeys: String, CodingKey {
//        case job
//        case department
//        case creditId = "credit_id"
//        case adult
//        case gender
//        case id
//        case knownForDepartment = "known_for_department"
//        case name
//        case originalName = "original_name"
//        case popularity
//        case profilePath = "profile_path"
//    }
//}
//
//// MARK: - GuestStar Model
//struct GuestStar: Codable {
//    let character: String
//    let creditId: String
//    let order: Int
//    let adult: Bool
//    let gender: Int
//    let id: Int
//    let knownForDepartment: String
//    let name: String
//    let originalName: String
//    let popularity: Double
//    let profilePath: String?
//
//    // CodingKeys to map JSON keys to Swift property names
//    enum CodingKeys: String, CodingKey {
//        case character
//        case creditId = "credit_id"
//        case order
//        case adult
//        case gender
//        case id
//        case knownForDepartment = "known_for_department"
//        case name
//        case originalName = "original_name"
//        case popularity
//        case profilePath = "profile_path"
//    }
//}
