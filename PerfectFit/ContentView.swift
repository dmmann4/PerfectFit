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
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    SwingDataView()
                        .tabItem {
                            Label("My Swing", systemImage: "figure.golf")
                        }
                    ShaftsListView(shafts: networking.shafts)
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
            .onAppear {
                let networkkin = EbayNetworking()
                networkkin.startAuthFlow()
                networkkin.getRelatedItems()
            }
        }
    }
}
    
    /// subtabview at the top for shaft category
    /// search/filter options

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

