//
//  SeasonButton.swift
//  Stars Play
//
//  Created by Asif Ayub on 17/02/2025.
//

import SwiftUI

struct SeasonButton: View {
    let seasonNumber: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text("Season \(seasonNumber)")
                .font(.subheadline)
                .foregroundColor(isSelected ? AppColors.textPrimary : AppColors.textSecondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .onTapGesture(perform: action)
            if isSelected {
                Rectangle().fill(AppColors.accent).frame(height: 2).cornerRadius(2)
            }
        }
    }
}
