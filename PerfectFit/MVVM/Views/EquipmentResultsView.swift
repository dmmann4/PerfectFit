//
//  EquipmentResultsView.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//


struct EquipmentResultsView: View {
    
    @ObservedObject var viewModel: SwingDataViewModel
    
    var body: some View {
        VStack {
            Text("We've found \(viewModel.sortedShafts.count) shafts that would work best for you!")
            ShaftsListView(shafts: viewModel.sortedShafts, clubType: .wood)
            Spacer()
        }
        .padding(20)
    }
}