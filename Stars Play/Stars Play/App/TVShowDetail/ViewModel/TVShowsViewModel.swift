//
//  TVShowsViewModel.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//

import Foundation
import NetworkClient

class TVShowsViewModel: ObservableObject {
    
    
    @Published var tvShow: TVShow? = nil
    @Published var selectedSeason: SeasonDetail? = nil
    @Published var episodes: [Episode] = []
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    var apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchTVShowDetails(by id: Int) async {
        do {
            let tVShowJSON = try await apiService.fetchTVShowDetails(showId: id)
            guard let tvShow = parseTVShow(from: tVShowJSON) else {
                throw NSError(domain: "Data parsing error", code: 1001)
            }
            await MainActor.run { [weak self] in
                self?.tvShow = tvShow
                self?.selectedSeason = self?.tvShow?.seasons.first
            }
            guard tvShow.numberOfSeasons > 0 else { return }
            await fetchSeasonDetail(tvShowID: id, seasonNumber: 0)
        } catch {
            await MainActor.run { [weak self] in
                self?.errorMessage = error.localizedDescription
                self?.showErrorAlert = true
            }
        }
    }
    
    func fetchSeasonDetail(tvShowID: Int, seasonNumber: Int) async {
        if let tvShow = tvShow, tvShow.seasons.count > seasonNumber, let episodes = tvShow.seasons[seasonNumber].episodes, episodes.count > 0 {
            
            await MainActor.run { [weak self] in
                self?.selectedSeason = tvShow.seasons[seasonNumber]
                self?.episodes = tvShow.seasons[seasonNumber].episodes ?? []
            }
            return
        }
        do {
            let seasonDetailJSON = try await apiService.fetchSeasonDetails(showId: tvShowID, seasonNumber: seasonNumber)
            guard let episodes = parseSeasonDetail(from: seasonDetailJSON)?.episodes else {
                throw NSError(domain: "Data parsing error", code: 1001)
            }
            guard let tvShow = self.tvShow, tvShow.seasons.count > seasonNumber else { return }
            await MainActor.run { [weak self] in
                self?.episodes = episodes
                self?.tvShow?.seasons[seasonNumber].episodes = episodes
            }
        } catch {
            await MainActor.run { [weak self] in
                self?.errorMessage = error.localizedDescription
                self?.showErrorAlert = true
            }
        }
    }
}

extension TVShowsViewModel: Hashable {
    static func == (lhs: TVShowsViewModel, rhs: TVShowsViewModel) -> Bool {
        lhs.tvShow?.id == rhs.tvShow?.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(tvShow?.id)
    }
}
