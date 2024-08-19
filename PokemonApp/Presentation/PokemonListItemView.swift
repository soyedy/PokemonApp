//
//  PokemonListItemView.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 18/08/24.
//

import Foundation
import SwiftUI

struct PokemonListItemView: View {
  var pokemon: PokemonDetailResponse
  var body: some View {
    HStack(spacing: 20) {
      AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }
      .shadow(color: .black, radius: 3, x: 0, y: 5)
      .frame(width: 120, height: 120)
      .background(Color.blue.opacity(0.09))
      .clipShape(.buttonBorder)

      VStack(alignment: .leading, spacing: 5) {
        Text(pokemon.name)
          //.font(.headline)
          .font(.custom("Marker Felt", size: 20))
          .foregroundStyle(.primary)
        Text("\(pokemon.height) ft")
          .font(.subheadline)
          .foregroundStyle(.gray)
          .font(.custom("Marker Felt", size: 20))
        Text("\(pokemon.weight) kg")
          .font(.subheadline)
          .foregroundStyle(.gray)
          .font(.custom("Marker Felt", size: 20))
      }
      Spacer()

    }
    .padding(.horizontal, 20)
  }
}
