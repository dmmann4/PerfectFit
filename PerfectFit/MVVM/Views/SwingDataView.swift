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
                    Text("Enter average driver carry distance")
                }
                .textFieldStyle(RoundedTextfieldView())
                .padding(20)
                TextField(text: $viewModel.fitProfile.swingSpeed) {
                    Text("Enter avarage driver swing speed")
                }
                .textFieldStyle(RoundedTextfieldView())
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
                .buttonStyle(.bordered)
                Spacer()
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
            Text("We've found \(viewModel.sortedShafts.count) shafts that would work best for you!")
            List {
                ShaftsListView(shafts: viewModel.sortedShafts, clubType: .wood)
            }
            Spacer()
        }
        .padding(20)
    }
}
