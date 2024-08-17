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
      Color.red.opacity(0.2)
        .edgesIgnoringSafeArea(.all)
      
      NavigationView {
        ScrollView {
          LazyVGrid(columns: gridLayout) {
            ForEach(viewModel.pokemonDetailedList, id: \.name) { pokemon in
              PokemonGridItemView(pokemon: pokemon)
            }
          }
          .onAppear() {
            Task {
              await viewModel.getPokemonsList()
            }
          }
        }
        .navigationTitle("Choose a Pokemon")
        .background(Color.red.ignoresSafeArea(.all))
      }
    }
  }
}

struct PokemonGridItemView: View {
  var pokemon: PokemonDetailResponse
  
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }
      .frame(width: 180, height: 180)
      .background(Color.gray.opacity(0.4))
      .cornerRadius(20)
      
      Text(pokemon.name)
        .font(.headline)
        .foregroundColor(.primary)
        .padding(.top, 8)
    }
    .padding()
    .cornerRadius(50)
    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
  }
}

