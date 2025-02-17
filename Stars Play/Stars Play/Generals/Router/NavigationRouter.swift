//
//  NavigationRouter.swift
//  Stars Play
//
//  Created by Asif Ayub on 16/02/2025.
//


import Foundation
import SwiftUI

final class NavigationRouter: ObservableObject {
        
    @Published var path = [Route]()
    
    func goBack(withAnimation animate: Bool = true) {
        if animate {
            path.removeLast()
        } else {
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                path.removeLast()
            }
        }
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func push(to screen: Route, withAnimation animate: Bool = true) {
        if animate {
            path.append(screen)
        } else {
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                path.append(screen)
            }
        }
    }
    
    func pop(to screen: Route) {
        if let index = path.firstIndex(of: screen) {
            let length = index + 1
            path = Array(path.prefix(upTo: length))
        }
    }
    
    enum Route: Hashable {
        
        case none
        case tvShowDetail(tvShowID: Int, viewModel: TVShowsViewModel)
        case epsideDetail(episode: Episode)
        case videoPlayerView(urlString: String)
                
        @ViewBuilder
        var screen: some View {
            switch self {
            case .none:
                EmptyView()
            case .tvShowDetail(let tvShowID, let viewModel):
                TVShowDetailView(tvShowID: tvShowID, viewModel: viewModel)
            case .epsideDetail(let episode):
                EpisodeDetailView(episode: episode)
            case .videoPlayerView(let urlString):
                VideoPlayerView(urlString: urlString)
            }
        }
    }
}
