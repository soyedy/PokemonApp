//
//  PokemonGridItemView.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 18/08/24.
//

import Foundation
import SwiftUI

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
        .shadow(color: .black, radius: 3, x: 0, y: 5)
        .frame(width: 100, height: 100)
        .background(Color.blue.opacity(0.09))
        .clipShape(.buttonBorder)
        
        Text(pokemon.name)
          //.font(.headline)
          .foregroundColor(.primary)
          .font(.custom("Marker Felt", size: 20))
      }
      .padding()
    }
  }
}
