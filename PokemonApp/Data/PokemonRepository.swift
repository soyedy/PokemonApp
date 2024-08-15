//
//  PokemonRepository.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

protocol PokemonRepositoryProtocol {
  func getList() async throws -> [Pokemon]
  func getDetail(of pokemon: String) async throws -> PokemonDetailResponse
}

struct PokemonRepository: PokemonRepositoryProtocol {
  
  func getList() async throws -> [Pokemon] {
    let service: PokemonService = .getBaseUrl
    let (data, response) = try await URLSession.shared.data(from: service.getAddress)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw FetchingErrors.unexpectedError
    }
    
    try catchError(of: httpResponse)
    
    do {
      let list = try decodeData(data: data, as: PokemonListResponse.self)
      return list.results
    } catch {
      print("Decoding error: \(error.localizedDescription)")
      throw FetchingErrors.clientError
    }
  }
  
  func getDetail(of pokemon: String) async throws -> PokemonDetailResponse {
    let (data, response) = try await URLSession.shared.data(from: URL(string: pokemon)!)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw FetchingErrors.unexpectedError
    }
    
    try catchError(of: httpResponse)
    
    do {
      return try decodeData(data: data, as: PokemonDetailResponse.self)
    } catch {
      print("Decoding error: \(error.localizedDescription)")
      throw FetchingErrors.clientError
    }
  }
  
  private func decodeData<T: Decodable>(data: Data, as type: T.Type) throws -> T {
    let decoder = JSONDecoder()
    do {
      return try decoder.decode(type, from: data)
    } catch {
      print("Decoding error: \(error.localizedDescription)")
      throw FetchingErrors.clientError
    }
  }
  
  private func catchError(of response: HTTPURLResponse) throws {
    switch response.statusCode {
    case 200...299:
      return
    case 400...499:
      print("Client error: \(response.statusCode)")
      throw FetchingErrors.clientError
    case 500...599:
      print("Server error: \(response.statusCode)")
      throw FetchingErrors.serverError
    default:
      print("Unexpected error: \(response.statusCode)")
      throw FetchingErrors.unexpectedError
    }
  }
}
