//
//  SeasonEpisodeCell.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//

import SwiftUI

struct SeasonEpisodeCell: View {
    let title: String
    let imagePath: String
    let playTapAction: () -> Void
    var detailTapAction: (() -> Void)? = nil
    var downloadTapAction: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Button(action: {
                detailTapAction?()
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(AppColors.textPrimary)
            }

            ZStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ZStack {
                        Rectangle().fill(AppColors.textSecondary.opacity(0.3))
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(width: 100, height: 60)
                .padding(.vertical, 15)
                .onTapGesture(perform: playTapAction)

                Button(action: playTapAction) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(AppColors.textPrimary.opacity(0.4))
                }
            }

            Text(title)
                .font(AppFonts.headline)
                .foregroundColor(AppColors.textPrimary)

            Spacer()

            Button(action: {
                downloadTapAction?()
            }) {
                Image(systemName: "arrow.down.to.line")
                    .foregroundColor(AppColors.textPrimary)
            }
        }
        .padding(.horizontal)
        .background(AppColors.textSecondary.opacity(0.2))
    }
}
