//
//  PokemonPresentationView.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 18/08/24.
//

import Foundation
import SwiftUI

struct PokemonPresentationView: View {
  @ObservedObject var viewModel: PokemonViewModel
  var style: PresentationMode
  private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  var body: some View {
    switch style {
    case .grid:
      LazyVGrid(columns: gridLayout) {
        ForEach(viewModel.pokemonFilteredList, id: \.id) { pokemon in
          PokemonGridItemView(pokemon: pokemon)
        }
      }
    case .list:
      ForEach(viewModel.pokemonFilteredList, id: \.id) { pokemon in
        PokemonListItemView(pokemon: pokemon)
      }
    }
  }
}
