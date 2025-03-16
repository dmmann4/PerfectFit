//
//  FitProfile.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/13/25.
//

import Foundation

enum StaffStiffness: String, CaseIterable {
    case senior = "Senior"
    case regular = "Regular"
    case stiff = "Stiff"
    case extraStiff = "Extra Stiff"
    
    init?(speed: Int) {
        switch speed {
        case 0..<75:
            self = .senior
        case 75..<95:
            self = .regular
        case 95..<110:
            self = .stiff
        case 110..<200:
            self = .extraStiff
        default:
            self = .regular
        }
    }
    
    var stringCategory: String {
        switch self {
        case .senior:
            return "A"
        case .regular:
            return "R"
        case .stiff:
            return "S"
        case .extraStiff:
            return "X"
        }
    }
}



struct FitProfile: Codable {
    var swingSpeed: String
    var carryDistance: String
//    let attackAngle: String?
//    let launchAngle: String?
//    let clubType: ClubType?
//    let whereIsMiss: MissHitType?
    
    
}

enum MissHitType: String, Codable, CaseIterable, Hashable {
    case left = "left"
    case right = "right"
    case thin = "thin"
    case chunk = "chunk"
    case short = "short"
    case long = "long"
}

