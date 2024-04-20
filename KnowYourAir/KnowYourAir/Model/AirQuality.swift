//
//  AirQuality.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 12/11/2023.
//

import Foundation

public struct AirQuality: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case co
        case no2
        case o3
        case so2
        case pm25 = "pm2_5"
        case pm10
    }
    
    public enum AirQualityRank: String {
        case good = "Good"
        case fair = "Fair"
        case moderate = "Moderate"
        case poor = "Poor"
        case veryPoor = "Very Poor"
        case unKnown = "Unknown"
    }
    
    var co: Double = 201.9
    var no2: Double = 0.7
    var o3: Double = 68.6
    var so2: Double = 0.6
    var pm25: Double = 0.5
    var pm10: Double = 0.5
    
    var airQuality: AirQualityRank {
        if isGood() { return .good }
        if isFair() { return .fair }
        if isModerate() { return .moderate }
        if isPoor() { return .poor}
        
        return .veryPoor
    }
    
    private func isGood () -> Bool {
        let so2Good = 0.0..<20.0
        let no2Good = 0.0..<40.0
        let pm10Good = 0.0..<20.0
        let pm25Good = 0.0..<10.0
        let o3Good = 0.0..<60.0
        let coGood = 0.0..<4400.0
        
        if so2Good.contains(so2) && no2Good.contains(no2) && pm10Good.contains(pm10) && pm25Good.contains(pm25) && o3Good.contains(o3) && coGood.contains(co) {
            return true
        }
        return false
    }
    
    private func isFair () -> Bool {
        let so2Fair = 0.0..<80.0
        let no2Fair = 0.0..<70.0
        let pm10Fair = 0.0..<50.0
        let pm25Fair = 0.0..<25.0
        let o3Fair = 0.0..<100.0
        let coFair = 0.0..<9400.0
        
        if so2Fair.contains(so2) && no2Fair.contains(no2) && pm10Fair.contains(pm10) && pm25Fair.contains(pm25) && o3Fair.contains(o3) && coFair.contains(co) {
            return true
        }
        return false
    }
    
    private func isModerate () -> Bool {
        let so2Moderate = 0.0..<250.0
        let no2Moderate = 0.0..<150.0
        let pm10Moderate = 0.0..<100.0
        let pm25Moderate = 0.0..<50.0
        let o3Moderate = 0.0..<140.0
        let coModerate = 0.0..<12400.0
        
        if so2Moderate.contains(so2) && no2Moderate.contains(no2) && pm10Moderate.contains(pm10) && pm25Moderate.contains(pm25) && o3Moderate.contains(o3) && coModerate.contains(co) {
            return true
        }
        return false
    }
    
    private func isPoor () -> Bool {
        let so2Poor = 0.0..<350.0
        let no2Poor = 0.0..<200.0
        let pm10Poor = 0.0..<200.0
        let pm25Poor = 0.0..<75.0
        let o3Poor = 0.0..<180.0
        let coPoor = 0.0..<15400.0
        
        if so2Poor.contains(so2) && no2Poor.contains(no2) && pm10Poor.contains(pm10) && pm25Poor.contains(pm25) && o3Poor.contains(o3) && coPoor.contains(co) {
            return true
        }
        return false
    }
}


