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
  var selectedPokemon: PokemonDetailResponse? { get set }
  var shouldShowError: Bool { get set }
  func getPokemonsList() async
  func getPokemonDetail(with name: String) async throws
}

final class PokemonViewModel: PokemonViewModelProtocol {
  @Published var pokemonList: [Pokemon] = []
  @Published var shouldShowError: Bool = false
  @Published var selectedPokemon: PokemonDetailResponse?
  
  var interactors: PokemonInteractorsProtocol
  
  init(interactors: PokemonInteractorsProtocol) {
    self.interactors = interactors
  }
  
  func getPokemonsList() async {
    do {
      let list: [Pokemon] = try await interactors.getPokemonsInteractor.execute()
      await MainActor.run {
        self.pokemonList = list
      }
    } catch {
      await MainActor.run {
        self.shouldShowError = true
      }
    }
  }
  
  func getPokemonDetail(with name: String) async throws {
    do {
      let pokemonDetail: PokemonDetailResponse = try await interactors.getPokemonDetailInteractor.execute(with: name)
      await MainActor.run {
        self.selectedPokemon = pokemonDetail
      }
    } catch {
      await MainActor.run {
        self.shouldShowError = true
      }
    }
  }
}
