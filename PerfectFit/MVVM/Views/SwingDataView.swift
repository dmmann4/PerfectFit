//
//  SwingDataViewMVVM.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/13/25.
//

import SwiftUI

struct SwingDataView: View {
    
    @ObservedObject var viewModel = SwingDataViewModel()
    private let swingSpeed: [String] = ["60", "70", "80", "90", "100", "110", "120", "130", "140", "150", "160", "180"]
    private let carryDistance: [String] = ["120", "130", "140", "150", "160", "170", "180", "190", "200", "210", "220", "230", "240", "250", "260", "270", "280", "290", "300"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Approx Carry Distance", selection: $viewModel.fitProfile.carryDistance) {
                    ForEach(carryDistance, id: \.self) { distance in
                        Text(distance)
                    }
                }
                .pickerStyle(.navigationLink)
                .padding(20)
                Picker("Approx swing speed", selection: $viewModel.fitProfile.swingSpeed) {
                    ForEach(swingSpeed, id: \.self) { speed in
                        Text(speed)
                    }
                }
                .pickerStyle(.navigationLink)
                .padding(20)
                Picker("Select Club type", selection: $viewModel.clubType) {
                    ForEach(ClubType.allCases) { club in
                        Text(club.stringVal)
                    }
                }
                .pickerStyle(.navigationLink)
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
                Button {
                    viewModel.fitProfile.carryDistance = ""
                    viewModel.fitProfile.swingSpeed = ""
                } label: {
                    Text("Reset")
                }
                .buttonStyle(.borderless)
                .padding(20)
                NavigationLink(destination: EquipmentResultsView(viewModel: viewModel), isActive: $viewModel.isSHowingResults) {
                    EmptyView()
                }
                
            }
        }
    }
}

#Preview {
    SwingDataView(viewModel: SwingDataViewModel())
}

