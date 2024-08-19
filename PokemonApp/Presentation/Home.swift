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
  @State private var isDataLoaded: Bool = false
  @State var presentationMode: PresentationMode = .grid(items: [])
  
  var body: some View {
    ZStack {
      VStack {
        NavigationView {
          ScrollView {
            SearchTextfieldView(
              searchText: searchTextField, presentationMode: presentationMode,
              title: "Search a pokemon") {
                withAnimation(.easeOut) {
                  presentationMode.toggle()
                }
              }
              .fontWeight(.bold)
              .foregroundStyle(.orange)
            Divider()
            if isDataLoaded {
              PokemonPresentationView(style: presentationMode)
            }
          }
          .background(Color("pokemon-colors"))
          .navigationTitle("Choose a Pokemon")
        }
      }
    }
    .onAppear() {
      Task {
        await fetchData()
      }
    }
  }
  
  private func fetchData() async {
    await viewModel.getPokemonsList()
    DispatchQueue.main.async {
      presentationMode = .grid(items: viewModel.pokemonDetailedList)
      isDataLoaded = true
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
            repository: PokemonRepository()))))
  }
}
