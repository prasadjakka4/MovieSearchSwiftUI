//
//  MovieResponseModel.swift
//  MovieSearch
//
//  Created by Prasad Jakka on 07/06/24.
//

import Foundation

struct MovieResponseModel: Decodable {
    
    var Search: [MovieModel]
}


struct MovieModel: Decodable, Identifiable, Hashable {
    var title: String
    var year: String
    var imdbId: String
    var movieUrl: String
    var id: String {
        imdbId
    }
   private  enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year =  "Year"
        case imdbId = "imdbID"
       case movieUrl = "Poster"
    }
}
