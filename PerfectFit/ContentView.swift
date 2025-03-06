//
//  ContentView.swift
//  PerfectFit
//
//  Created by Mann Fam on 2/11/25.
//

import SwiftUI
import SwiftData
import TabularData
import ComposableArchitecture

enum ClubType: String, CaseIterable, Codable {
    case wood = "WOODS"
    case hybrid = "HYBRIDS"
    case iron = "IRONS"
    case wedge = "WEDGES"
    case unknown = ""
}

struct Shafts {
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
}


struct ContentView: View {
    let networking = FakeNetworking.shared
    var body: some View {
        NavigationStack {
            TabView {
                shaftListView(shafts: networking.shafts)
                    .tabItem {
                        Label("All Shafts", systemImage: "list.dash")
                    }
                userSwingDataView()
                    .tabItem {
                        Label("My Swing", systemImage: "square.and.pencil")
                    }
            }
            .navigationTitle("Perfect Fit")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func userSwingDataView() -> some View {
        SwingDataView(store: PerfectFitApp.store)
    }
    
    /// subtabview at the top for shaft category
    /// search/filter options
    private func shaftListView(shafts: [Shafts]) -> some View {
        VStack(alignment: .leading) {
            List {
                ForEach(ClubType.allCases, id: \.self) { clubType in
                    Section(header: Text(clubType.rawValue)) {
                        ForEach(shafts, id: \.name) { shaft in
                            if shaft.clubType == clubType {
                                VStack {
                                    HStack(alignment: .top) {
                                        Text(shaft.name)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.headline)
                                            .fontWeight(.heavy)
                                        Spacer()
                                        Text(shaft.material)
                                            .padding(5)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10).fill(.gray).opacity(0.3))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.bottom, 24)
                                    HStack {
                                        Text(shaft.flex)
                                        Spacer()
                                        Text(shaft.launch)
                                        Spacer()
                                        Text("\(shaft.weight)g")
                                    }.fontWeight(.medium)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}


extension FileManager {
    func listFiles(path: String) -> [URL] {
        let baseurl: URL = URL(fileURLWithPath: path)
        var urls = [URL]()
        enumerator(atPath: path)?.forEach({ (e) in
            guard let s = e as? String else { return }
            let relativeURL = URL(fileURLWithPath: s, relativeTo: baseurl)
            let url = relativeURL.absoluteURL
            urls.append(url)
        })
        return urls
    }
}

final class FakeNetworking {
    static let shared = FakeNetworking()
    private var shaftFilesArray: [String] = ["Woods-Table", "Irons-Table", "Wedges-Table", "Hybrids-Table"]
    public var shafts: [Shafts] = []
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
                                let shaft = Shafts(
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
