//
//  Enums+Extensions.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

enum FetchingErrors: Error {
  case serverError
  case clientError
  case unexpectedError
}

enum PresentationMode {
  case grid(items: [PokemonDetailResponse])
  case list(items: [PokemonDetailResponse])
  
  mutating func toggle() {
    switch self {
    case .grid(let items):
      self = .list(items: items)
    case .list(let items):
      self = .grid(items: items)
    }
  }
}
