//
//  SearchTextfieldView.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 18/08/24.
//

import Foundation
import SwiftUI

struct SearchTextfieldView: View {
  @State var searchText: String
  var presentationMode: PresentationMode
  var title: String
  var action: (() -> Void)
  
  var body: some View {
    HStack {
      TextField(title, text: $searchText)
        .frame(height: 20)
      Button(action: action) {
        switch presentationMode {
        case .grid:
          Image(systemName: "rectangle.grid.1x2")
            .font(.headline)
        case .list:
          Image(systemName: "square.grid.3x2")
            .font(.headline)
        }

      }
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 20)
  }
}
