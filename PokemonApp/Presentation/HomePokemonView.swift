//
//  HomePokemonView.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import SwiftUI

@MainActor
struct HomePokemonView: View {
  @ObservedObject var viewModel: PokemonViewModel
  private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
  
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVGrid(columns: gridLayout) {
          ForEach(viewModel.pokemonList, id: \.name) { pokemon in
            Text(pokemon.name)
          }
        }
        .onAppear() {
          Task {
            await viewModel.getPokemonsList()
          }
        }
      }
    }
  }
}


