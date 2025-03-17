//
//  Shaft.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//

import Foundation

struct Shaft: Identifiable {
    var id: UUID = UUID()
    let name: String
    let clubType: ClubType
    let code: String
    let MPF: String
    let material: String
    let flex: String
    let weight: String
    let torque: String
    let bendPoint: String
    let tipStiffness: String
    let launch: String
    let price: String
    
    
    static let sampleShaft: Shaft = Shaft(
        name: "Diamana GT Series 40",
        clubType: .wood,
        code: "MR0102",
        MPF: "2D1S",
        material: "Graphite",
        flex: "R2",
        weight: "46",
        torque: "5.6",
        bendPoint: "mid/high",
        tipStiffness: "med/firm",
        launch: "low/mid",
        price: "$360.00")
}
