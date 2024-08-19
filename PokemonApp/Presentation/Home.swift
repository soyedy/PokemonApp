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
  @State var presentationMode: PresentationMode = .grid
  
  var body: some View {
    ZStack {
      VStack {
        NavigationView {
          ScrollView {
            SearchTextfieldView(
              searchText: $searchTextField, 
              viewModel: viewModel,
              presentationMode: presentationMode,
              title: "Search a pokemon") {
                withAnimation(.linear) {
                  presentationMode.toggle()
                }
              }
              .fontWeight(.bold)
              .foregroundStyle(Color("AccentColor"))
            Divider()
            if isDataLoaded {
              PokemonPresentationView(
                viewModel: viewModel,
                style: presentationMode)
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
