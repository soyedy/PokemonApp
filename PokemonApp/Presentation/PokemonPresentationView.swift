//
//  PokemonPresentationView.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 18/08/24.
//

import Foundation
import SwiftUI

struct PokemonPresentationView: View {
  var style: PresentationMode
  private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  var body: some View {
    switch style {
    case .grid(let items):
      LazyVGrid(columns: gridLayout) {
        ForEach(items, id: \.id) { pokemon in
          PokemonGridItemView(pokemon: pokemon)
        }
      }
    case .list(let items):
      ForEach(items, id: \.id) { pokemon in
        PokemonListItemView(pokemon: pokemon)
      }
    }
  }
}
