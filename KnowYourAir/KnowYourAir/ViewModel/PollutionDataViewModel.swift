//
//  DataViewModel.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 12/11/2023.
//

import Foundation

class PollutionDataViewModel: ObservableObject {
    @Published var pollutionData: PollutionData?
    let locationManager: LocationManager
    
    private let dataProvider: PollutionDataProvider
    
    init(pollutionData: PollutionData?, dataProvider: PollutionDataProvider = PollutionDataProvider(), locationManager: LocationManager = LocationManager()) {
        self.pollutionData = pollutionData
        self.dataProvider = dataProvider
        self.locationManager = locationManager
    }
    
    func fetchData(lat: Double = 51.5, lon: Double = 0.1) {
        Task { @MainActor in
           let data = await self.dataProvider.getAirQuality(lat: lat, lon: lon)
           self.pollutionData = data
        }
    }
    
    func refreshLocation() {
        do {
            try locationManager.getAuth()
        } catch {
            // error management
            print(error)
        }
    }
}
