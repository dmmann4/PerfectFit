//
//  LaunchScreenView.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/14/25.
//

import SwiftUI
import Foundation 
import Lottie

enum LaunchScreenStep {
    case firstStep
    case secondStep
    case finished
}

final class LaunchScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep

    @MainActor func dismiss() {
        Task {
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(1))

            self.state = .finished
        }
    }
}


struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager // Mark 1

    @State private var firstAnimation = false  // Mark 2
    @State private var secondAnimation = false // Mark 2
    @State private var startFadeoutAnimation = false // Mark 2
    @State private var animationCount = 0
    @State private var titleOpactiy = false
    
    @ViewBuilder
    private var image: some View {  // Mark 3
        ZStack {
            LottieView(animation: .named("SplashAnimation"))
                .playing(loopMode: .repeat(1.0))
                .animationDidFinish { completed in
                    self.launchScreenState.dismiss()
                }
                Text("Perfect Fit")
                    .font(.system(size: 64, weight: .bold, design: .serif))
                    .padding(.bottom, 400)
                    .opacity(titleOpactiy ? 1.0 : 0.0)
                    .foregroundStyle(Color.white)
                Spacer()
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(Animation.default.speed(0.2)) {
                    titleOpactiy.toggle()
                }
            }
        }
    }
    
    @ViewBuilder
    private var backgroundColor: some View {  // Mark 3
        Color.corePrimary.ignoresSafeArea()
    }
    
    private let animationTimer = Timer // Mark 5
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor  // Mark 3
            image  // Mark 3
        }.onReceive(animationTimer) { timerValue in
            updateAnimation()  // Mark 5
        }.opacity(startFadeoutAnimation ? 0 : 1)
    }
    
    private func updateAnimation() { // Mark 5
        switch launchScreenState.state {  
        case .firstStep:
            withAnimation(.easeInOut(duration: 0.9)) {
                firstAnimation.toggle()
            }
        case .secondStep:
            if secondAnimation == false {
                withAnimation(.linear) {
                    self.secondAnimation = true
                    startFadeoutAnimation = true
                }
            }
        case .finished: 
            // use this case to finish any work needed
            break
        }
    }
    
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
