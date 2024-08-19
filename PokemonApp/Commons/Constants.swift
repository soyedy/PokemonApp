//
//  Constants.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

enum PokemonService {
  case getBaseUrl
  case searchByName(name: String)
  
  var getAddress: URL {
    switch self {
    case .getBaseUrl:
      return URL(string: "https://pokeapi.co/api/v2/pokemon?limit=500")!
    case .searchByName(let pokemonName):
      return URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonName)")!
    }
  }
}
