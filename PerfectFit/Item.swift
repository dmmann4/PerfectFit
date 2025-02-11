//
//  Item.swift
//  PerfectFit
//
//  Created by Mann Fam on 2/11/25.
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
