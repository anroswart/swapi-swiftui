//
//  Film.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

import UIKit.UIImage

class Film: Decodable, Identifiable {
    var title: String?
    var releaseDate: String?
    var director: String?
    var producer: String?
    var openingCrawl: String?
    var characterURLs: [String]?
    var characterList: [String]?
    var rating: Double?
    var posterData: Data?
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case director
        case producer
        case openingCrawl = "opening_crawl"
        case charactersURLs = "characters"
    }
    
    convenience init(title: String?, releaseDate: String?, director: String?, producer: String?, openingCrawl: String?, characterURLs: [String]?) {
        self.init()
        self.title = title
        self.releaseDate = releaseDate
        self.director = director
        self.producer = producer
        self.openingCrawl = openingCrawl
        self.characterURLs = characterURLs
    }
    
    convenience required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decodeIfPresent(String.self, forKey: .title)
        let releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        let director = try container.decodeIfPresent(String.self, forKey: .director)
        let producer = try container.decodeIfPresent(String.self, forKey: .producer)
        let openingCrawl = try container.decodeIfPresent(String.self, forKey: .openingCrawl)
        let characterURLs = try container.decodeIfPresent([String].self, forKey: .charactersURLs)
        
        self.init(title: title, releaseDate: releaseDate, director: director, producer: producer, openingCrawl: openingCrawl, characterURLs: characterURLs)
    }
}
