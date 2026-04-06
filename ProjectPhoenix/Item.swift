//
//  Item.swift
//  ProjectPhoenix
//
//  Created by JASON ROBERTS on 06/04/2026.
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
