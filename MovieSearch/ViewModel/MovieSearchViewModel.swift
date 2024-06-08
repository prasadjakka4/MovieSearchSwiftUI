//
//  MovieSearchViewModel.swift
//  MovieSearch
//
//  Created by Prasad Jakka on 07/06/24.
//

import Foundation
import Combine
class MovieSearchViewModel: ObservableObject {
    var apiManager: APIManager
    @Published var movieList = [MovieModel]()
    var cancellable: Set<AnyCancellable> = []
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func fetchMovies(searchText: String) {
        self.apiManager.fetchDefaultMovieList(searchStr: searchText).sink { completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        } receiveValue: { [weak self] list in
            self?.movieList = list
        }.store(in: &cancellable)

    }
    
}
