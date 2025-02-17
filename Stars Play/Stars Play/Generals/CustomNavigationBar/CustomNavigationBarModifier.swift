//
//  CustomNavigationBarModifier.swift
//  Stars Play
//
//  Created by Asif Ayub on 17/02/2025.
//


import SwiftUI
import CachedAsyncImage


struct CustomNavigationBarModifier: ViewModifier {
    @EnvironmentObject var router: NavigationRouter
    var title: String? = nil
    var onBackButtonTapped: (() -> Void)? = nil
    
    
    func body(content: Content) -> some View {
        VStack {
            ZStack {
                
                HStack(spacing: 16) {
                    Button(action: {
                        if let onBackButtonTapped = onBackButtonTapped {
                            onBackButtonTapped()
                        } else {
                            router.goBack()
                        }
                    }) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .frame(width: 15, height: 20)
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    if let title = title {
                        Text(title)
                            .font(.headline)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.bottom, 5).padding(.top, 5)
            }
            .frame(height: 48)
            content
                .toolbar(.hidden)
                .navigationBarBackButtonHidden(true)
        }
    }
}

extension View {
    func customNavigationModifier(
        title: String? = nil,
        onBackButtonTapped: (() -> Void)? = nil
    ) -> some View {
        self.modifier(CustomNavigationBarModifier(title: title, onBackButtonTapped: onBackButtonTapped))
    }
}
