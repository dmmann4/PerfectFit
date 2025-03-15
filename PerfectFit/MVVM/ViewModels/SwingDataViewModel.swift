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
    @Published var fitProfile: FitProfile = FitProfile(swingSpeed: "300", carryDistance: "100")

    
    public func findShafts(completion: @escaping (Bool) -> Void) {
        /// calc what stiffness based on swing speed
        guard let speed: Int = Int(fitProfile.swingSpeed) else {
            return
        }
        let staffStiffness: StaffStiffness = StaffStiffness(speed: speed) ?? .senior
//        let sortedShafts = networking.shafts.sorted { (shaft1, shaft2) -> Bool in
//            return shaft1.flex < shaft2.flex
//        }
//        sortedShafts.forEach { shaft in
//            print("Shaft stiffness -- \(shaft.flex)")
//        }
       
        let shaftsThatFit = networking.shafts.filter { (shaft) -> Bool in
            return shaft.flex.lowercased() == staffStiffness.stringCategory.lowercased() && shaft.clubType == .wood
        }
        self.sortedShafts = shaftsThatFit
        completion(true)
    }
    
}
