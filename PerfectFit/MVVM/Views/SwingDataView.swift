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
            .background(Color.corePrimary)
            .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    SwingDataView(viewModel: SwingDataViewModel())
}

