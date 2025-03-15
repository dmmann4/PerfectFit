//
//  SwingDataViewMVVM.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/13/25.
//

import SwiftUI

struct SwingDataView: View {
    
    @ObservedObject var viewModel = SwingDataViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField(text: $viewModel.fitProfile.carryDistance) {
                    Text("What would you say your average driver carry distance is?")
                }
                .padding(20)
                TextField(text: $viewModel.fitProfile.swingSpeed) {
                    Text("What is your avarage swing speed with your driver??")
                }
                .padding(20)
                Button {
                    viewModel.isLoadingResults = true
                    viewModel.findShafts() { success in
                        viewModel.isLoadingResults = false
                        viewModel.isSHowingResults = true
                    }
                } label: {
                    Text("Find my fit!")
                }

                NavigationLink(destination: EquipmentResultsView(viewModel: viewModel), isActive: $viewModel.isSHowingResults) {
                    EmptyView()
                }
            }
        }
    }
}

struct EquipmentResultsView: View {
    
    @ObservedObject var viewModel: SwingDataViewModel
    
    var body: some View {
        VStack {
            Text("Here are the shafts that would work best for you!")
                .padding(20)
            ShaftsListView(shafts: viewModel.sortedShafts, clubType: .wood)
            Spacer()
        }
    }
}
