//
//  PerfectFitApp.swift
//  PerfectFit
//
//  Created by Mann Fam on 2/11/25.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct PerfectFitApp: App {
    
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
      }
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
