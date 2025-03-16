//
//  FakeNetworking.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//

import Foundation

final class FakeNetworking {
    static let shared = FakeNetworking()
    private var shaftFilesArray: [String] = ["Woods-Table", "Irons-Table", "Wedges-Table", "Hybrids-Table"]
    public var shafts: [Shaft] = []
    private init() { parseShaftItems() }
    
    private func parseShaftItems() {
        var clubType: ClubType = .unknown
        shaftFilesArray.forEach { file in
            if let path = Bundle.main.path(forResource: file, ofType: "csv") {
                let url = URL(fileURLWithPath: path)
                do {
                    let data = try Data(contentsOf: url)
                    let dataEncoded = String(data: data, encoding: .utf8)
                    if  let dataArr = dataEncoded?.components(separatedBy: "\r\n").map({ $0.components(separatedBy: ";") }) {
                        for line in 0..<dataArr.count {
                            let items = dataArr[line][0].components(separatedBy: ",")
                            
                            if items.count == 1 {
                                clubType = ClubType(rawValue: items[0]) ?? .unknown
                            }
                            if items.count > 10 {
                                let shaft = Shaft(
                                    name: items[0],
                                    clubType: clubType,
                                    code: items[1],
                                    MPF: items[2],
                                    material: items[3],
                                    flex: items[4],
                                    weight: items[5],
                                    torque: items[6],
                                    bendPoint: items[7],
                                    tipStiffness: items[8],
                                    launch: items[9],
                                    price: items[10])
                                shafts.append(shaft)
                            }
                        }
                    }
                    shafts.forEach { shaft in
                        print("Type: \(shaft.clubType) - Name: \(shaft.name) - launch: \(shaft.launch)")
                    }
                } catch let jsonErr {
                    print("\n Error reading CSV file: \n ", jsonErr)
                }
            }
        }
    }
}
