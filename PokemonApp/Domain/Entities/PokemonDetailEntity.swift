//
//  PokemonDetailEntity.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

struct Pokemon: Codable {
  var name: String
  var url: String
}

struct PokemonListResponse: Codable {
  let results: [Pokemon]
}

struct Ability: Codable {
  let ability: AbilityDetail
  let isHidden: Bool
  let slot: Int
  
  enum CodingKeys: String, CodingKey {
    case ability
    case isHidden = "is_hidden"
    case slot
  }
}

struct AbilityDetail: Codable {
  let name: String
  let url: String
}

struct Cries: Codable {
  let latest: String
  let legacy: String
}

struct Form: Codable {
  let name: String
  let url: String
}

struct PokemonDetailResponse: Codable {
  let abilities: [Ability]
  let baseExperience: Int
  let cries: Cries
  let forms: [Form]
  
  enum CodingKeys: String, CodingKey {
    case abilities
    case baseExperience = "base_experience"
    case cries
    case forms
  }
}
