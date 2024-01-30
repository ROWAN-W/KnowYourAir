//
//  Pollutiondata.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 25/12/2023.
//

import Foundation

struct PollutionData {
    let coord: Coordinates
    let time: TimeInterval
    let airQuality: AirQuality
    
    init(coord: Coordinates = Coordinates(lat: 51.5, lon: 0.128), time: Double = 1605182400, airQuality: AirQuality = AirQuality()) {
        self.coord = coord
        self.time = time
        self.airQuality = airQuality
    }
}

struct Coordinates: Decodable {
    let lat: Double
    let lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
