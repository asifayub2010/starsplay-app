//
//  TVShowRow.swift
//  Stars Play
//
//  Created by Asif Ayub on 17/02/2025.
//

import SwiftUI

struct TVShowRow: View {
    let show: TVShowItem
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(show.name)
                .font(AppFonts.headline)
                .foregroundColor(AppColors.textPrimary)

            Text(show.overview)
                .font(AppFonts.subheadline)
                .foregroundColor(AppColors.textSecondary)
                .lineLimit(3)
                .lineSpacing(4)

            HStack {
                Text("Rating: \(show.voteAverage, specifier: "%.1f")")
                    .foregroundColor(AppColors.textSecondary)
                Spacer()
                Text("Release Date: \(show.firstAirDate)")
                    .foregroundColor(AppColors.textSecondary)
            }
            .font(AppFonts.caption)
        }
        .padding()
        .background(AppColors.rowBackground)
        .cornerRadius(8)
        .onTapGesture(perform: onTap)
    }
}
