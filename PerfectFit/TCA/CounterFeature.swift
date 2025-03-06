//
//  CounterFeature.swift
//  PerfectFit
//
//  Created by Mann Fam on 2/19/25.
//

import ComposableArchitecture
import SwiftUI

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                Button("Fact") {
                    /// dont worry about returning the result, return the fact that you called async task
                    store.send(.factButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                if store.isLoading {
                    ProgressView()
                } else if let fact = store.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            case .factButtonTapped:
                state.isLoading = true
                state.fact = nil
//                return await .runAysnc { send in // this runs the task is not the task itself!!
//                    let (data, _) = try await URLSession.shared
//                        .data(from: URL(string: "http://numbersapi.com/\(7)")!)
//                    let fact = String(decoding: data, as: UTF8.self)
//                    
//                    send(.factResponse(fact))
//                }
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact))
                }
            case let .factResponse(fact):
                    state.fact = fact
                    state.isLoading = false
                    return .none
            }
        }
    }
}


extension Effect {
    public static func runAysnc(operation: @escaping @Sendable (_ send: Send<Action>) async throws -> Void) async -> Self {
        Effect.run(priority: .background) { send in
            try await operation(send)
        }
    }
}


/// actual first feature
/// enter info into textfields
/// press button to get shaft types
/// sort through shafts
/// return shaft types that fit the user
///

struct FindYourFitView: View {
    var body: some View {
        Text("Hello, World!")
    }
}


@Reducer
struct FitterFeature {
    @ObservableState
    struct State {
        var fitProfile: FitProfile?
        var isLoadingFit = false
        var shaftsThatFit: [Shafts] = []
        var shouldResetData = false
    }
    
    enum Action {
        case loadFitProfile(FitProfile, [Shafts])
        case fitProfileLoaded([Shafts])
        case resetProfile
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadFitProfile(let profile, let shafts):
                state.fitProfile = profile
                return .run { send in
                    // run some kind of function to sort and filter
                    var filteredShafts = shafts.filter { shaft in
                        return shaft.clubType == profile.clubType
                    }
                    if profile.swingSpeed < "50" {
                        filteredShafts = filteredShafts.filter({ shafts in
                            return shafts.flex.lowercased() != "s"
                        })
                    }
                    await send(.fitProfileLoaded(filteredShafts))
                }
            case .fitProfileLoaded(let shafts):
                state.shaftsThatFit = shafts
                return .none
            case .resetProfile:
                state.shaftsThatFit = []
                state.fitProfile = nil
                state.shouldResetData = true
                return .none
            }
        }
    }
}

struct FitProfile: Codable {
    let swingSpeed: String
    let attackAngle: String
    let launchAngle: String
    let clubType: ClubType
    let whereIsMiss: MissHitType
}

enum MissHitType: String, Codable, CaseIterable, Hashable {
    case left = "left"
    case right = "right"
    case thin = "thin"
    case chunk = "chunk"
    case short = "short"
    case long = "long"
}
