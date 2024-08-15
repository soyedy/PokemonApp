//
//  Constants.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

struct PokemonAppConstants {
  var base: URL {
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
      return URL(fileURLWithPath: "")
    }
    return url
  }
}
