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
  @State var searchTextField: String = ""
  private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  var body: some View {
    ZStack {
      VStack {
        NavigationView {
          ScrollView {
            HStack {
              TextField("Search a pokemon", text: $searchTextField)
                .frame(height: 20)
              Button(action: {}) {
                Image(systemName: "list.bullet")
                  .font(.headline)
                  .foregroundStyle(.primary)
              }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            
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
          .fontWeight(.bold)
          .foregroundStyle(.orange)
        }

      }
    }
  }
}

struct PokemonGridItemView: View {
  var pokemon: PokemonDetailResponse
  
  var body: some View {
    ZStack {
      VStack {
        AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .shadow(color: .primary, radius: 3, x: 0, y: 5)
        .frame(width: 100, height: 100)
        .background(Color.blue.opacity(0.09))
        .clipShape(.buttonBorder)
        
        Text(pokemon.name)
          .font(.headline)
          .foregroundColor(.primary)
      }
      .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomePokemonView(
      viewModel: PokemonViewModel(
        interactors: PokemonInteractors(
          getPokemonsInteractor: GetPokemonList(
            repository: PokemonRepository()),
          getPokemonDetailInteractor: GetPokemonDetail(
            repository: PokemonRepository()))))    }
}
