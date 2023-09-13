//
//  TmdbSearch.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

struct TmdbSearchResponse: Decodable {
    let results: [TmdbSearchResult]
}

struct TmdbSearchResult: Decodable {
    let title: String?
    let posterPath: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case rating = "vote_average"
    }
}
