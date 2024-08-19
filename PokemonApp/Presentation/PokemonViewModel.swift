//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

protocol PokemonViewModelProtocol: ObservableObject {
  var interactors: PokemonInteractorsProtocol { get }
  var pokemonRawList: [Pokemon] { get set }
  var shouldShowError: Bool { get set }
  func getPokemonsList() async
  func getPokemonDetail(with name: String) async throws -> PokemonDetailResponse?
}

final class PokemonViewModel: PokemonViewModelProtocol {
  @Published var pokemonRawList: [Pokemon] = []
  @Published var shouldShowError: Bool = false
  @Published var pokemonDetailedList: [PokemonDetailResponse] = []
  
  var interactors: PokemonInteractorsProtocol
  
  init(interactors: PokemonInteractorsProtocol) {
    self.interactors = interactors
  }
  
  func getPokemonsList() async {
    do {
      self.pokemonRawList = try await interactors.getPokemonsInteractor.execute()
      for pokemon in pokemonRawList {
        if let detailedPokemon = try await self.getPokemonDetail(with: pokemon.url) {
          await MainActor.run {
            self.pokemonDetailedList.append(detailedPokemon)
            self.pokemonDetailedList = self.pokemonDetailedList.compactMap { $0 }
            self.pokemonDetailedList.shuffle()
          }
        }
      }
    } catch {
      await MainActor.run {
        self.shouldShowError = true
      }
    }
  }
  
  func getPokemonDetail(with name: String) async throws -> PokemonDetailResponse? {
    return try? await interactors.getPokemonDetailInteractor.execute(with: name)
  }
}

