//
//  EquipmentResultsView.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//

import SwiftUI

struct EquipmentResultsView: View {
    
    @ObservedObject var viewModel: SwingDataViewModel
    
    var body: some View {
        VStack {
            Text("We've found \(viewModel.sortedShafts.count) shafts that would work best for you!")
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
            ShaftsListView(shafts: viewModel.sortedShafts)
            Spacer()
        }
        .padding(20)
    }
}
