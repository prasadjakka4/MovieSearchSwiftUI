//
//  MovieSearchApp.swift
//  MovieSearch
//
//  Created by Prasad Jakka on 07/06/24.
//

import SwiftUI

@main
struct MovieSearchApp: App {
    var body: some Scene {
        WindowGroup {
            MovieSearchView(model: MovieSearchViewModel(apiManager: APIManager.shared))
        }
    }
}
