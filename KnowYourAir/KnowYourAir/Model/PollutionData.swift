//
//  Pollutiondata.swift
//  KnowYourAir
//
//  Created by Rowy on 25/12/2023.
//

import Foundation

struct PollutionData {
    let coord: Coordinates
    let time: String
    let airQuality: AirQuality
    
    init(coord: Coordinates = Coordinates(latitude: 51.5, longitude: 0.128), time: String = "1605182400", airQuality: AirQuality = AirQuality()) {
        self.coord = coord
        self.time = time
        self.airQuality = airQuality
    }
}

struct Coordinates {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
