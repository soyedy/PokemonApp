//
//  PokemonInteractors.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

protocol PokemonInteractorsProtocol {
  var getPokemonsInteractor: GetPokemonList { get }
  var getPokemonDetailInteractor: GetPokemonDetail { get }
}

struct PokemonInteractors: PokemonInteractorsProtocol {
  var getPokemonsInteractor: GetPokemonList
  var getPokemonDetailInteractor: GetPokemonDetail
}

struct GetPokemonList {
  var repository: PokemonRepositoryProtocol
  
  func execute() async throws -> [Pokemon] {
    return try await repository.getList()
  }
}

struct GetPokemonDetail {
  var repository: PokemonRepositoryProtocol
  
  func execute(with pokemon: String) async throws -> PokemonDetailResponse {
    return try await repository.getDetail(of: pokemon)
  }
}
