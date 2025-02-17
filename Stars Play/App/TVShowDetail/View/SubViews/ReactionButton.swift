//
//  ReactionButton.swift
//  Stars Play
//
//  Created by Asif Ayub on 17/02/2025.
//

import SwiftUI

struct ReactionButton: View {
    let title: String
    let systemImageName: String
    var action: (() -> Void)? = nil
    var body: some View {
        VStack(spacing: 5) {
            ZStack {
                Image(systemName: systemImageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
            }
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
        }.onTapGesture {
            action?()
        }
    }
}
