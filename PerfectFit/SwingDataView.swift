//
//  SwingDataView.swift
//  PerfectFit
//
//  Created by Mann Fam on 2/19/25.
//

import SwiftUI
import ComposableArchitecture

enum SwingSpeeds: CaseIterable {
    case senior
    case regular
    case stiff
    case extraStiff
}

struct SwingDataView: View {
    var swingSpeedRanges: [SwingSpeeds: String] = [
        SwingSpeeds.senior: "30-70",
        SwingSpeeds.regular: "70-90",
        SwingSpeeds.stiff: "91-110",
        SwingSpeeds.extraStiff: "111+"
    ]
    let store: StoreOf<FitterFeature>
    @State var swingSpeed: String = ""
    @State var attackAngle: String = ""
    @State var launchAngle: String = ""
    @State var clubType: ClubType = .wood
    @State var missLocation: MissHitType = .short
    var body: some View {
        NavigationStack {
            VStack {
                Text("Let us know your swing data")
                    .padding(20)
                // swing speed
                Picker("What's your swing speed?", selection: $swingSpeed) {
                    ForEach(Array(swingSpeedRanges.keys.enumerated()), id:\.element) { key, miss in
                        Text(self.swingSpeedRanges[miss] ?? "")
                    }
                }
                .padding(20)
                // attack andgle
                TextField(text: $attackAngle) {
                    Text("What's your attack angle?")
                }
                // launch andgle
                TextField(text: $launchAngle) {
                    Text("What's your launch angle?")
                }
                .padding(20)
                // Where is your miss?
                Picker("Where is your miss?", selection: $missLocation) {
                    ForEach(MissHitType.allCases, id: \.self) { miss in
                        Text(miss.rawValue)
                    }
                }
                .padding(20)
                Picker("What club type is this info for?", selection: $clubType) {
                    ForEach(ClubType.allCases, id: \.self) { club in
                        Text(club.rawValue)
                    }
                }
                .padding(20)
                Spacer()
                Button {
                    store.send(.loadFitProfile(FitProfile(swingSpeed: swingSpeed, attackAngle: attackAngle, launchAngle: launchAngle, clubType: clubType, whereIsMiss: missLocation), FakeNetworking.shared.shafts))
                } label: {
                    Text("Find my fit")
                }
                Spacer()
                if store.shaftsThatFit.count > 0 {
                    Text("TOTAL SHAFTS THAT FIT: \(store.shaftsThatFit.count)")
                }
                Spacer()
                Button {
                    store.send(.resetProfile)
                } label: {
                    Text("Reset fit")
                }
            }
            .onChange(of: store.shouldResetData, perform: { lhs in
                if lhs == true {
                    swingSpeed = ""
                    attackAngle = ""
                    launchAngle = ""
                }
            })
            .padding(20)
            .pickerStyle(.navigationLink)
        }
    }
}
