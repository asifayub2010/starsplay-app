//
//  EpisodeDetailView.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//


import SwiftUI
import AVKit

struct EpisodeDetailView: View {
    @EnvironmentObject var router: NavigationRouter
    let episode: Episode
    @State private var readmore = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Poster Image
                if let stillPath = episode.stillPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(stillPath)")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(height: 250)
                    }
                    .background(Color.gray.opacity(0.3))
                }
                VStack(alignment: .leading, spacing: 10) {
                    // Episode Name
                    Text(episode.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    if let airDate = episode.airDate {
                        // Air Date
                        Text(airDate)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    // Overview
                    if !episode.overview.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(episode.overview)
                                .lineLimit(readmore ? 100 : 3)
                                .foregroundColor(.white)
                            
                            Button(action: {
                                readmore.toggle()
                            }) {
                                Text(readmore ? "Read less" : "Read More")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Play Button
                    Button(action: {
                        router.push(to: .videoPlayerView(urlString: videoURLString))
                    }) {
                        Text("Play Content")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(2)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark Theme
        .customNavigationModifier()
    }
}
