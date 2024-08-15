//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

protocol PokemonViewModelProtocol: ObservableObject {
  var interactors: PokemonInteractorsProtocol { get }
  var pokemonList: [Pokemon] { get set }
  var shouldShowError: Bool { get set }
  func getPokemonsList() async
}

final class PokemonViewModel: PokemonViewModelProtocol {
  @Published var pokemonList: [Pokemon] = []
  @Published var shouldShowError: Bool = false
  
  var interactors: PokemonInteractorsProtocol
  
  init(interactors: PokemonInteractorsProtocol) {
    self.interactors = interactors
  }
  
  func getPokemonsList() async {
    do {
      let list: [Pokemon] = try await interactors.getPokemonsInteractor.execute()
      await MainActor.run() {
        self.pokemonList = list
      }
    } catch {
      self.shouldShowError = true
    }
  }
}
