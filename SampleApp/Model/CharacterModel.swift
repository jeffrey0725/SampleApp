//
//  CharacterModel.swift
//  SampleApp
//
//  Created by Jeffrey Cheung on 22/6/2022.
//

import Foundation

struct CharacterModel: Codable {
    var characters: [Characters]?
    var count: Int?
    var previousPage: String?
    var nextPage: String?
    
    enum CodingKeys: String, CodingKey {
        case characters = "data"
        case count = "count"
        case previousPage = "previousPage"
        case nextPage = "nextPage"
    }
}

struct Characters: Codable {
    var _id: Int?
    var url: String?
    var name: String?
    var sourceUrl: String?
    var films: [String]?
    var shortFilms: [String]?
    var tvShows: [String]?
    var videoGames: [String]?
    var alignment: String?
    var parkAttractions: [String]?
    var allies: [String]?
    var enemies: [String]?
    var imageUrl: String?
}
