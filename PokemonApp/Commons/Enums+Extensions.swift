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
  case grid
  case list
  
  mutating func toggle() {
    switch self {
    case .grid:
      self = .list
    case .list:
      self = .grid
    }
  }
}
