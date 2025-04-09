//
//  SwingDataViewModel.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/13/25.
//

/* Carry Distance (driver)
 
 Swing Speed (driver)

 Flex

 Under 200 yards

 Under 75 mph

 Ladies or Senior

 200 to 240 yards

 75 to 95 mph

 Regular

 240 to 275 yards

 95 to 110 mph

 Stiff

 Over 275 yards

 Over 110 mph

 Stiff or Extra Stiff*/

//var swingSpeedRanges: [StaffStiffness: String] = [
//    StaffStiffness.senior: "30-70",
//    StaffStiffness.regular: "70-90",
//    StaffStiffness.stiff: "91-110",
//    StaffStiffness.extraStiff: "111+"
//]

enum SwingRange {
    
}



import Foundation

class SwingDataViewModel: ObservableObject {
    
    let networking = FakeNetworking.shared
    @Published var isLoadingResults: Bool = false
    @Published var isSHowingResults: Bool = false
    @Published var sortedShafts: [Shaft] = []
    @Published var fitProfile: FitProfile = FitProfile(swingSpeed: "", carryDistance: "")
    @Published var clubType: ClubType = .wood
    
    public func findShafts(completion: @escaping (Bool) -> Void) {
        /// calc what stiffness based on swing speed
        guard let speed: Int = Int(fitProfile.swingSpeed) else {
            return
        }
        sortedShafts = calcFitting(clubType: .wood, swingSpeed: speed, carryDistance: Int(fitProfile.carryDistance) ?? 0, handedness: "right", prefrences: [])
        completion(true)
    }
    
}
