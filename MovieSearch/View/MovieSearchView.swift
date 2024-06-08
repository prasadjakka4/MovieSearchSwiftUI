//
//  MovieSearchView.swift
//  MovieSearch
//
//  Created by Prasad Jakka on 07/06/24.
//

import SwiftUI
import Combine

struct MovieSearchView: View {
@ObservedObject  var model: MovieSearchViewModel
@State var searchText = ""
    var searchSubject = CurrentValueSubject<String,Never>("")
@State var cancellable: Set<AnyCancellable> = []
    init(model: MovieSearchViewModel) {
        self.model = model
    }
    var body: some View {
        
        NavigationStack {
            List(model.movieList, id: \.id) {
                model in
                NavigationLink(destination: MovieDetailView(model: model)) {
                    MovieListCellView(model: model)
                }
                .navigationTitle("Movies")
            }.searchable(text: $searchText)
                .onChange(of: searchText) { text in
                    searchSubject.send(text)
                }
        }.onAppear(){
            setupSearchSubject()
            self.model.fetchMovies(searchText: "")
        }
    }
    
    func setupSearchSubject() {
        searchSubject.debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .sink {  text in
                model.fetchMovies(searchText: text)
            }.store(in: &cancellable)
    }
}


struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView(model: MovieSearchViewModel(apiManager: APIManager.shared))
    }
}

