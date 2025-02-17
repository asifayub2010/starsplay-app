//
//  TVShowViewModel.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//


import Foundation
import NetworkClient

class TVShowViewModel: ObservableObject {
    @Published var tvShows: [TVShowItem] = []
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    var apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchTVShows() async {
        do {
            let json = try await apiService.fetchTVShowsList()
            guard let tvShows = parseTVShowsListDetail(from: json)?.results else {
                throw NSError(domain: "Data parsing error", code: 1001, userInfo: nil)
            }
            await MainActor.run { [weak self] in
                self?.tvShows = tvShows
            }
        } catch {
            await MainActor.run { [weak self] in
                self?.errorMessage = error.localizedDescription
                self?.showErrorAlert = true
            }
            
        }
    }
}
