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
    let quality: AirQuality
    
    init(coord: Coordinates = Coordinates(latitude: 51.5, longitude: 0.128), time: String = "1605182400", quality: AirQuality = AirQuality()) {
        self.coord = coord
        self.time = time
        self.quality = quality
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
