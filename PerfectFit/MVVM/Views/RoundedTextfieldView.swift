//
//  RoundedTextfieldView.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//

import SwiftUI

struct RoundedTextfieldView: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(
                Color(UIColor.systemGray6)
            )
            .clipShape(Capsule(style: .continuous))
    }
}
