//
//  Stars_PlayApp.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//

import SwiftUI
import NetworkClient

@main
struct Stars_PlayApp: App {
    let apiService = APIServiceFactory.create(apiKey: "ecef14eac236a5d4ec6ac3a4a4761e8f", baseURL: "https://api.themoviedb.org/3")
    var body: some Scene {
        WindowGroup {
            TVShowListView(viewModel: TVShowViewModel(apiService: apiService))
                .preferredColorScheme(.dark) // Ensure dark theme
        }
    }
}
