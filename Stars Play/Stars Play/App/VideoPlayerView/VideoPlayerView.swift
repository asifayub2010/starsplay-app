//
//  VideoPlayerView.swift
//  Stars Play
//
//  Created by Asif Ayub on 17/02/2025.
//


import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let urlString: String
    
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
    var body: some View {
        VStack {
            // Video Player
            VideoPlayer(player: player)
                .frame(height: 300)
                .cornerRadius(8)
                .padding()
            
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark Theme
        .onAppear {
            if let url = URL(string: urlString) {
                player = AVPlayer(url: url)
                player?.play()
            }
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(urlString: "")
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}
