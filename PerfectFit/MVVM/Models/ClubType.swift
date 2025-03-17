//
//  ClubType.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//

import Foundation

enum ClubType: String, CaseIterable, Codable, Identifiable {
    case wood = "WOODS"
    case hybrid = "HYBRIDS"
    case iron = "IRONS"
    case wedge = "WEDGES"
    
    var stringVal: String {
        switch self {
        case .wood:
            return "Driver/Wood"
        case .hybrid:
            return "Hybrid"
        case .iron:
            return "Iron"
        case .wedge:
            return "Wedge"
        }
    }
    
    var id: Self { self }
}
