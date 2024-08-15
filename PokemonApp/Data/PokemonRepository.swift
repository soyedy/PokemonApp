//
//  PokemonRepository.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation

protocol PokemonRepositoryProtocol {
  func getList() async throws -> [Pokemon]
  func getDetail(of pokemon: Pokemon) async throws
}

struct PokemonRepository: PokemonRepositoryProtocol {
  private let constants: PokemonAppConstants = PokemonAppConstants()
  
  func getList() async throws -> [Pokemon] {
    let (data, response) = try await URLSession.shared.data(from: constants.base)
    
    if let httpResponse = response as? HTTPURLResponse {
      try self.catchError(of: httpResponse)
      let list = try self.decodeData(data: data, as: PokemonListResponse.self)
      return list.results
    } else {
      throw FetchingErrors.clientError
    }
  }
  
  func getDetail(of pokemon: Pokemon) async throws {
    
  }
  
  private func decodeData<T: Decodable>(data: Data, as type: T.Type) throws -> T {
    let decoder = JSONDecoder()
    do {
      return try decoder.decode(type, from: data)
    } catch {
      throw FetchingErrors.clientError
    }
  }
  
  private func catchError(of response: HTTPURLResponse) throws {
    switch response.statusCode {
    case 200...299:
      return
    case 400...499:
      throw FetchingErrors.clientError
    case 500...599:
      throw FetchingErrors.serverError
    default:
      throw FetchingErrors.unexpectedError
    }
  }
  
}
