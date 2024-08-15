//
//  PokemonAppApp.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import SwiftUI

@main
struct PokemonApp: App {
  var body: some Scene {
    WindowGroup {
      HomePokemonView(
        viewModel: PokemonViewModel(
          interactors: PokemonInteractors(
            getPokemonsInteractor: GetPokemonList(
              repository: PokemonRepository()),
            getPokemonDetailInteractor: GetPokemonDetail(
              repository: PokemonRepository()))))
    }
  }
}
