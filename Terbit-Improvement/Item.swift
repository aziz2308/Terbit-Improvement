//
//  Item.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 13/05/25.
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
