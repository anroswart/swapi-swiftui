//
//  Swapi.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

struct SwapiFilmsResponse: Decodable {
    let count: Int
    let results: [Film]
}

struct SwapiCharacterResponse: Decodable {
    let name: String
}
