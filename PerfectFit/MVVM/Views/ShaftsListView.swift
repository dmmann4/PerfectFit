//
//  ShaftsListView.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//

import SwiftUI

struct ShaftsListView: View {
    
    let shafts: [Shaft]
    let clubType: ClubType
    
    var body: some View {
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
