//
//  ShaftDetailView.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//

import SwiftUI

struct ShaftDetailView: View {
    let shaft: Shaft
    var body: some View {
        VStack {
            Text(shaft.name)
                .font(.title)
            HStack {
                SubDetailView(value: ("Price", shaft.price))
                Spacer().frame(width: 36)
                SubDetailView(value: ("Flex", shaft.flex))
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 20)
            HStack {
                SubDetailView(value: ("Material", shaft.material))
                Spacer()
                SubDetailView(value: ("Weight", shaft.weight))
                Spacer()
                SubDetailView(value: ("Club Type", shaft.clubType.rawValue))
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 20)
            HStack {
                SubDetailView(value: ("Launch Point", shaft.launch))
                Spacer()
                SubDetailView(value: ("Bend Point", shaft.bendPoint))
                Spacer()
                SubDetailView(value: ("Torque", shaft.torque))
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 20)
            Spacer()
        }
        .background(Color.corePrimary)
        .foregroundStyle(Color.white)
        
    }
}

struct SubDetailView: View {
    let value: (title: String, details: String)
    var body: some View {
        VStack {
            Text(value.title)
                .padding(8)
                .fontWeight(.bold)
                .underline()
            Text(value.details)
        }
    }
}

#Preview {
    ShaftDetailView(shaft: Shaft.sampleShaft)
}
