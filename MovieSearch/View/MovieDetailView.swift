//
//  MovieDetailView.swift
//  MovieSearch
//
//  Created by Prasad Jakka on 07/06/24.
//

import SwiftUI

struct MovieDetailView: View {
    var model: MovieModel
    init(model: MovieModel) {
        self.model = model
    }
    var body: some View {
        VStack {

            ImageView(imageUrl: model.movieUrl)
                .frame(width: 400, height: 400)
                    .aspectRatio(contentMode: .fit)
            Text(model.title).font(.system(size: 30.0))
            Text(model.year).font(.system(size: 20.0))

        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(model: MovieModel(title: "", year: "", imdbId: "", movieUrl: ""))
    }
}
