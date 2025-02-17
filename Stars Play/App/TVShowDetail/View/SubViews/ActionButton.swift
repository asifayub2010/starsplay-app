//
//  ActionButton.swift
//  Stars Play
//
//  Created by Asif Ayub on 17/02/2025.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let systemImageName: String
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemImageName)
                .frame(width: 6, height: 6)
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(backgroundColor)
        .foregroundColor(.white)
        .cornerRadius(2)
        .onTapGesture(perform: action)
    }
}
