//
//  SwingDataView.swift
//  PerfectFit
//
//  Created by Mann Fam on 2/19/25.
//

import SwiftUI

struct SwingDataView: View {
    @State var isLeftHanded: Bool = false
    @State var swingSpeed: String = ""
    @State var missLocation: String = ""
    var body: some View {
        VStack {
            Text("Let us know your swing data")
            // handedness
            Toggle(isOn: $isLeftHanded) {
                Text("Are you left handed?")
            }
            // swing speed
            TextField(text: $swingSpeed) {
                Text("What's your swing speed?")
            }
            // Where is your miss?
            TextField(text: $missLocation) {
                Text("Where is your miss?")
            }
            Spacer()
        }
        .padding(20)
        
    }
}

#Preview {
    SwingDataView()
}
