//
//  FittingCalc.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/10/25.
//

// DATA POINTS AND HOW THEY ARE CALCULATED

/// SMASH FACTOR
/// - divide players ball speed by their club head speed


/// CARRY DISTANCE
/// - raw number


/// VERTICAL LAUNCH ANGLE
/// - will be different for different club types
///   ** need to find "ideal" ranges for these


/// ANGLE OF ATTACK
/// - measured in postive or negative number


/// BACK SPIN
/// - Spin is measured in RPM, raw number


/// DYNAMIC LIE
/// angle of the club at its point of turf interaction vs its angle before the swing starts

///
///

/// Kick point -> Higher the kick point the lower the ball flight
/// typically higher swing speeds want a higher kick point to keep the ball from balloning
/// potentially a question of getting the ball in the air for less talented players
///
///
/// Torque
/// Normally you'll see torque measurements from 2 degrees to about 7 degrees.
/// So the conventional wisdom that follows that definition is that a low-torque shaft number (2-3 degrees) would be for the higher swing speed and stiffer shaft type of golfer; while a high-torque shaft (4, 5, 6, 7-degrees plus) would be for a slower swing speed and lighter-weight shaft type of golfer.

/// Normally you'll see torque measurements from 2 degrees to about 7 degrees.

/// To the average golfer, a shaft with a low torque number such as 2.1 degrees would feel like you're swinging a pipe. The shaft will have a boardy feeling and stout. A high torque number such as 7 degrees would mean that the shaft is flexible and smoother.


// Initial ideas for a calculation

// levels of data seperated by importance

// 2-3 must have values

// 3-4 nice to haves

// maybe another 3-4 incredible to have data points

// Calculation shows % match based on input values
/// would I do this by % of parameters that are not nil?
/// or results based

extension SwingDataViewModel {
    
    //Example
    func calcFitting(clubType: ClubType, swingSpeed: Int, carryDistance: Int, handedness: String, attackAngle: Double? = nil, areaOfMiss: String? = "right", spinRate: Int? = nil, smashFactor: Double? = nil, launchAngle: Double? = nil, prefrences: [String]?) -> [Shaft] {
        var filteredShafts: [Shaft] = networking.shafts
        // shaft attributes to calc
        /// flex, weight, kick point, torque,
        if let areaOfMiss {
            if handedness == "right" && areaOfMiss == "right" || handedness == "left" && areaOfMiss == "left" {
                /// we want a mid to high kick point
                filteredShafts = filteredShafts.filter { $0.bendPoint == "low/mid" || $0.bendPoint == "mid" }
            }
        }
        
        if swingSpeed < 100 {
            // we want higher torque
            filteredShafts = filteredShafts.filter { $0.torque >= "4" }
        } else {
            // we want lower torque
            filteredShafts = filteredShafts.filter { $0.torque <= "3.9" }
        }
        
        let flex = StaffStiffness(speed: swingSpeed)
        
        filteredShafts = filteredShafts.filter { $0.flex.lowercased() == flex?.stringCategory.lowercased() }
        
        if let smashFactor, smashFactor <= 1.0 {
            /// we want a heavier club
        }
        
        filteredShafts = filteredShafts.filter { $0.clubType == clubType }
        
        return filteredShafts
    }
}
