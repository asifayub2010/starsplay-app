//
//  TVShowDetailView.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//

import SwiftUI
import CachedAsyncImage


struct TVShowDetailView: View {
    @ObservedObject var viewModel: TVShowsViewModel
    @EnvironmentObject var router: NavigationRouter
    @State private var selectedSeasonIndex = 0
    @State private var readmore = false
    private let tvShowID: Int

    init(tvShowID: Int, viewModel: TVShowsViewModel) {
        self.viewModel = viewModel
        self.tvShowID = tvShowID
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Banner Image
                BannerImageView(posterPath: viewModel.tvShow?.posterPath)

                titleSubTitleView
                    .padding(.horizontal)

                // Play and Trailer Buttons
                HStack(spacing: 16) {
                    ActionButton(title: "Play", systemImageName: "play", backgroundColor: AppColors.accent.opacity(0.8)) {
                        router.push(to: .videoPlayerView(urlString: videoURLString))
                    }
                    ActionButton(title: "Trailer", systemImageName: "video", backgroundColor: AppColors.textSecondary.opacity(0.3)) {
                        router.push(to: .videoPlayerView(urlString: videoURLString))
                    }
                }
                .frame(height: 40)
                .padding(.horizontal)

                // Overview Text with Read More Button
                overviewView
                    .padding(.horizontal)

                // Watchlist, Like, and Dislike Buttons
                HStack(spacing: 30) {
                    ReactionButton(title: "Watchlist", systemImageName: "plus") {
                        viewModel.errorMessage = "Feature under development: This action will be implemented soon."
                        viewModel.showErrorAlert = true
                    }
                    ReactionButton(title: "I like it", systemImageName: "hand.thumbsup") {
                        viewModel.errorMessage = "Feature under development: This action will be implemented soon."
                        viewModel.showErrorAlert = true
                    }
                    ReactionButton(title: "I don't like it", systemImageName: "hand.thumbsdown") {
                        viewModel.errorMessage = "Feature under development: This action will be implemented soon."
                        viewModel.showErrorAlert = true
                    }
                }
                .padding(.horizontal)

                seasonsListScrollable

                // Vertical List of Episodes
                LazyVStack(alignment: .leading, spacing: 2) {
                    ForEach(viewModel.episodes, id: \.id) { episode in
                        SeasonEpisodeCell(
                            title: episode.name,
                            imagePath: episode.stillPath ?? "",
                            playTapAction: {
                                router.push(to: .videoPlayerView(urlString: videoURLString))
                            },
                            detailTapAction: {
                                router.push(to: .epsideDetail(episode: episode))
                            }) {
                                viewModel.errorMessage = "Feature under development: This action will be implemented soon."
                                viewModel.showErrorAlert = true
                                
                            }
                    }
                }
            }
        }
        .background(AppColors.background.edgesIgnoringSafeArea(.all))
        .customNavigationModifier()
        .onAppear {
            Task {
                if viewModel.tvShow == nil {
                    await viewModel.fetchTVShowDetails(by: tvShowID)
                }
            }
        }
        .alert("Error", isPresented: $viewModel.showErrorAlert) {
            Button("OK", role: .cancel) { viewModel.showErrorAlert = false }
        } message: {
            if let message = viewModel.errorMessage {
                Text(message)
            }
        }
    }

    var seasonsListScrollable: some View {
        let numberOfSeasons = viewModel.tvShow?.numberOfSeasons ?? 0
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<numberOfSeasons, id: \.self) { seasonNumber in
                    SeasonButton(
                        seasonNumber: seasonNumber + 1,
                        isSelected: seasonNumber == selectedSeasonIndex,
                        action: {
                            selectedSeasonIndex = seasonNumber
                            Task {
                                await viewModel.fetchSeasonDetail(tvShowID: viewModel.tvShow?.id ?? 0, seasonNumber: seasonNumber + 1)
                            }
                        }
                    )
                    if seasonNumber + 1 != numberOfSeasons {
                        Rectangle().fill(Color.gray).frame(width: 1, height: 15)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    var titleSubTitleView: some View {
            // Title and Initiated Date
            VStack(alignment: .leading, spacing: 0) {
                if let name = viewModel.tvShow?.name {
                    Text(name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                if let releaseDate = viewModel.tvShow?.firstAirDate.toDate?.format("YYYY"), let totalSeasons = viewModel.tvShow?.numberOfSeasons {
                    Text("\(releaseDate)  |  \(totalSeasons) Season\(totalSeasons > 1 ? "s" : "")  |  R")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        
        var overviewView: some View {
            VStack(alignment: .leading, spacing: 4) {
                if let overview = viewModel.tvShow?.overview, !overview.isEmpty {
                    Text(overview)
                        .font(.callout)
                        .lineSpacing(0)
                        .lineLimit(readmore ? 100 : 3)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        readmore.toggle()
                    }) {
                        Text(readmore ? "Read less" : "Read More")
                            .foregroundColor(.orange)
                    }
                }
            }
        }
}


