//
//  Item.swift
//  PokemonApp
//
//  Created by John Edward Narvaez Londono on 14/08/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
