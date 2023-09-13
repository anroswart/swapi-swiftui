//
//  TmdbClientService.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

import Foundation

class TmdbClientService: NSObject {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchPostersAndRatings(forTitle title: String) async throws -> (image: Data?, rating: Double?) {
        let searchResult = try await searchFilms(forTitle: title)
        guard
            let tmdbImageURL = searchResult?.posterPath,
            !tmdbImageURL.isEmpty else {
            return (nil, searchResult?.rating)
        }
        let urlString: String = "https://image.tmdb.org/t/p/w500\(tmdbImageURL)"
        guard let url = URL(string: urlString) else {
            return (nil, searchResult?.rating)
        }
        let (posterImageData, response) = try await URLSession.shared.data(from: url)
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw NetworkError.invalidResponse
        }
        
        return (posterImageData, searchResult?.rating)
    }
    
    func searchFilms(forTitle title: String) async throws -> TmdbSearchResult? {
        let title = "Star Wars: \(title)"
        guard
            let movieTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return nil
        }
        let tmdbURLString: String = "https://api.themoviedb.org/3/search/movie?include_adult=false&query=\(movieTitle)&language=en-US&api_key=026ed4b253a6531903d424d2f2008911"
        let responseObject = try await getJSON(
            fromURL: tmdbURLString,
            withDecodableType: TmdbSearchResponse.self)
        let validObjects = responseObject.results.filter { $0.posterPath != nil }
        
        return validObjects.first
    }
}
