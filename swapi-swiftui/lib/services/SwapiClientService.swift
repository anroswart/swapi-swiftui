//
//  SwapiClientService.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

import Foundation

class SwapiClientService: NSObject {
    private var filmCharacterMap = [String: String]()
    
    func fetchFilms() async throws -> SwapiFilmsResponse {
        let filmsURL: String = "https://swapi.dev/api/films/"
        
        return try await getJSON(
            fromURL: filmsURL,
            withDecodableType: SwapiFilmsResponse.self)
    }
    
    func fetchCharacters(characterURLs: [String]) async throws -> [String] {
        await withTaskGroup(of: SwapiCharacterResponse.self) { taskGroup in
            for url in characterURLs {
                if filmCharacterMap.contains(where: { $0.key == url }) {
                    continue
                }
                taskGroup.addTask {
                    do {
                        let responseObject = try await getJSON(
                            fromURL: url,
                            withDecodableType: SwapiCharacterResponse.self)
                        self.filmCharacterMap[url] = responseObject.name
                        return responseObject
                    } catch {
                        return SwapiCharacterResponse(name: "Unknown Character")
                    }
                }
            }
        }
        
        return filmCharacterMap.compactMap {
            guard characterURLs.contains($0.key) else {
                return nil
            }
            return $0.value
        }
    }
}
