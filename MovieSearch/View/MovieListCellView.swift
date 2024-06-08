//
//  MovieListCellView.swift
//  MovieSearch
//
//  Created by Prasad Jakka on 07/06/24.
//

import SwiftUI

struct MovieListCellView: View {
    var model: MovieModel
    init(model: MovieModel) {
        self.model = model
    }
    var body: some View {
        HStack {
            ImageView(imageUrl: model.movieUrl).frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(model.title).bold()
                Divider()
                Text(model.year)
            }
        }     
    }
}

struct ImageView: View {
    var imageUrl: String
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    @ViewBuilder
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
    }
}

struct MovieListCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListCellView(model: MovieModel(title: "", year: "", imdbId: "", movieUrl: ""))
    }
}
