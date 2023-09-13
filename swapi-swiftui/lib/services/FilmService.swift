//
//  FilmService.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

import Foundation

class FilmService: NSObject {
    private var swapiClient: SwapiClientService
    private var tmdbClient: TmdbClientService
    var films = [Film]()
    
    init(withSWAPIClient swapiClient: SwapiClientService = SwapiClientService(), tbdbCleint: TmdbClientService = TmdbClientService()) {
        self.swapiClient = swapiClient
        self.tmdbClient = tbdbCleint
    }
    
    func fetchFilms() async throws -> [Film] {
        let filmsResponse = try await swapiClient.fetchFilms()
        self.films = filmsResponse.results.sorted {
            guard
                let firstDate = $0.releaseDate,
                let secondDate = $1.releaseDate
            else {
                return false
            }
            return firstDate < secondDate
        }
        try await getFilmsCharacters()
        try await getFilmsPostersAndRatings()
        
        return films
    }
    
    private func getFilmsCharacters() async throws {
        for (index, film) in self.films.enumerated() {
            guard
                (film.characterURLs?.count ?? 0) > 0
            else {
                continue
            }
            let characterList = try await swapiClient.fetchCharacters(characterURLs: Array(film.characterURLs!))
            films[index].characterList = characterList
        }
    }
    
    private func getFilmsPostersAndRatings() async throws {
        for (index, film) in self.films.enumerated() {
            guard
                let title = film.title
            else {
                continue
            }
            let (posterData, rating) = try await tmdbClient.fetchPostersAndRatings(forTitle: title)
            self.films[index].posterData = posterData
            self.films[index].rating = rating
        }
    }
}

