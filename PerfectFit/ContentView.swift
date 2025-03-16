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

struct ContentView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    let networking = FakeNetworking.shared
    
    init() {
        UITableView.appearance().backgroundColor = .corePrimary
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    SwingDataView()
                        .tabItem {
                            Label("My Swing", systemImage: "figure.golf")
                        }
                    shaftListView(shafts: networking.shafts)
                        .tabItem {
                            Label("All Shafts", systemImage: "cricket.ball")
                        }
                    WebKitView(url: URL(string: "https://www.worldwidegolfshops.com/insider/post/how-to-pick-a-golf-shaft-fps")!)
                        .tabItem {
                            Label("Club FAQ", systemImage: "questionmark.circle")
                        }
                }
            }
            .navigationTitle("Perfect Fit")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    
//    private func userSwingDataView() -> some View {
//        SwingDataView(store: PerfectFitApp.store)
//    }
    
    /// subtabview at the top for shaft category
    /// search/filter options
    private func shaftListView(shafts: [Shaft]) -> some View {
        VStack(alignment: .leading) {
            List {
                ForEach(ClubType.allCases, id: \.self) { clubType in
                    Section(header: Text(clubType.rawValue)) {
                        ShaftsListView(shafts: shafts, clubType: clubType)
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

