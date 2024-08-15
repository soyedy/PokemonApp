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

struct PokemonDetail: Codable {
  struct Sprites: Codable {
    let front_default: String
  }
  let sprites: Sprites
}

