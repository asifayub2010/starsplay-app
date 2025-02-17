//
//  BannerImageView.swift
//  Stars Play
//
//  Created by Asif Ayub on 17/02/2025.
//

import SwiftUI

struct BannerImageView: View {
    let posterPath: String?

    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath ?? "")")) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipped()
        } placeholder: {
            ProgressView()
                .frame(height: 250)
        }
    }
}
