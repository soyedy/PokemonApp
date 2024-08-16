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
    ZStack {
      NavigationView {
        ScrollView {
          LazyVGrid(columns: gridLayout) {
            ForEach(viewModel.pokemonList, id: \.name) { pokemon in
              PokemonGridItemView(pokemon: pokemon, viewModel: self.viewModel)
            }
          }
          .onAppear() {
            Task {
              await viewModel.getPokemonsList()
            }
          }
        }
        .navigationTitle("Choose a Pokemon")
      }
    }
  }
}

struct PokemonGridItemView: View {
  var pokemon: Pokemon
  @ObservedObject var viewModel: PokemonViewModel
  
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: viewModel.selectedPokemon?.sprites.frontDefault ?? "")) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }
      .frame(width: 120, height: 120)
      .background(Color.gray.opacity(0.2))
      .cornerRadius(10)
      
      Text(viewModel.selectedPokemon?.name ?? "")
        .font(.headline)
        .foregroundColor(.primary)
        .padding(.top, 8)
    }
    .onAppear() {
      Task {
        try await viewModel.getPokemonDetail(with: pokemon.url)
      }
    }
    .padding()
    .cornerRadius(10)
  }
}

struct DetailedPokemonView: View {
  var pokemonName: String
  @ObservedObject var viewModel: PokemonViewModel
  
  var body: some View {
    VStack {
      if let selectedPokemon = viewModel.selectedPokemon {
        AsyncImage(url: URL(string: "")) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 120, height: 120)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        
        Text("")
          .font(.headline)
          .foregroundColor(.primary)
          .padding(.top, 8)
      } else {
        ProgressView()
          .onAppear {
            Task {
              try await viewModel.getPokemonDetail(with: pokemonName)
            }
          }
      }
    }
    .padding()
    .cornerRadius(10)
    .navigationTitle(pokemonName.capitalized)
  }
}
