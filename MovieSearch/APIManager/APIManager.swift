//
//  APIManager.swift
//  MovieSearch
//
//  Created by Prasad Jakka on 07/06/24.
//

import Foundation
import Combine

enum APIError: Error {
    
    case UrlError
    case ResponseError
    case ParseError
    
}

protocol MovieSearchAPIRequestProtocol {
    
    func fetchDefaultMovieList(searchStr: String) -> AnyPublisher<[MovieModel], Error>
}

class APIManager: MovieSearchAPIRequestProtocol {
    static let shared = APIManager()
    private init() {}
    func fetchDefaultMovieList(searchStr: String) -> AnyPublisher<[MovieModel], Error> {
        guard let url = URL(string: generateMovieSearchUrlString(searchStr: searchStr).urlEncoded ?? "") else {
            return Fail(error: APIError.UrlError).eraseToAnyPublisher()
        }
        return fetchMovies(movieUrl: url)
    }
    
    func fetchUserSearchMovieList(movieName: String) -> AnyPublisher<[MovieModel], Error> {
        guard let url = URL(string: generateMovieSearchUrlString(searchStr: movieName).urlEncoded ?? "") else {
            return Fail(error: APIError.UrlError).eraseToAnyPublisher()
        }
        return fetchMovies(movieUrl: url)
    }

    
    
    private func fetchMovies(movieUrl: URL) -> AnyPublisher<[MovieModel], Error> {
        return URLSession.shared.dataTaskPublisher(for: movieUrl)
            .tryMap { data, response in
                guard let urlResponse = response as? HTTPURLResponse,
                      urlResponse.statusCode == 200  else {
                    throw APIError.ResponseError
                }
                return data
            }.decode(type: MovieResponseModel.self, decoder: JSONDecoder())
            .map(\.Search)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    func generateMovieSearchUrlString(searchStr: String) -> String {
        let searchMovieStr = searchStr.isEmpty ? "GodFather" : searchStr
        let urlStr = "https://www.omdbapi.com/?s=\(searchMovieStr)&i=tt3896198&apikey=775af237"
        return urlStr
    }
        
}


extension String {
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
