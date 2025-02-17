//
//  TVShowListView.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//


import SwiftUI

struct TVShowListView: View {
    @ObservedObject private var viewModel: TVShowViewModel
    @StateObject private var router: NavigationRouter = NavigationRouter()
    
    init(viewModel: TVShowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            List(viewModel.tvShows) { show in
                TVShowRow(show: show) {
                    router.push(to: .tvShowDetail(tvShowID: show.id, viewModel: TVShowsViewModel(apiService: viewModel.apiService)))
                }
            }
            .listStyle(PlainListStyle())
            .background(AppColors.background)
            .navigationTitle("Popular TV Shows")
            .onAppear {
                if viewModel.tvShows.isEmpty {
                    Task { await viewModel.fetchTVShows() }
                }
            }
            .refreshable {
                Task { await viewModel.fetchTVShows() }
            }
            .alert("Error", isPresented: $viewModel.showErrorAlert) {
                Button("OK", role: .cancel) { viewModel.showErrorAlert = false }
            } message: {
                if let message = viewModel.errorMessage {
                    Text(message)
                }
            }
            .navigationDestination(for: NavigationRouter.Route.self) { route in
                route.screen
            }
        }
        .accentColor(AppColors.textPrimary)
        .environmentObject(router)
    }
}
