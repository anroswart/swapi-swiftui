//
//  SplashScreenViewModel.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/13.
//

import Foundation

class SplashScreenViewModel: ObservableObject {
    @Published var isLoadingFilms = false
    @Published var films: [Film] = []
    @Published var showErrorAlert = false
    var errorMessage = ""
    private let filmService = FilmService()
    
    @MainActor
    func getFilmData() async {
        isLoadingFilms = true
        do {
            let films = try await filmService.fetchFilms()
            isLoadingFilms = false
            if films.isEmpty {
                try throwEmptyFilmsListError()
            }
            self.films = films
        } catch {
            self.errorMessage = error.localizedDescription
            self.showErrorAlert = true
        }
    }
    
    private func throwEmptyFilmsListError() throws {
        let localizedDescription = NSLocalizedString("No films returned.", comment: "The films list returend by the Star Wars API client was empty.")
        throw NSError(domain: "SplashScreenViewModel" , code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}
