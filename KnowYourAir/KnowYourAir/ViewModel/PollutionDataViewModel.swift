//
//  DataViewModel.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 12/11/2023.
//

import Foundation
import Combine

class PollutionDataViewModel: ObservableObject {
    @Published var pollutionData: PollutionData?
    @Published var shouldShowAlert: Bool = false
    let locationManager: LocationManager
    var subscriptions = Set<AnyCancellable>()
    
    
    private let dataProvider: PollutionDataProvider
    
    init(pollutionData: PollutionData?, dataProvider: PollutionDataProvider = PollutionDataProvider(), locationManager: LocationManager = LocationManager()) {
        self.pollutionData = pollutionData
        self.dataProvider = dataProvider
        self.locationManager = locationManager
        locationManager.$location.sink { [weak self] location in
            if let currentLocation = location {
                self?.fetchData(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
            }
        }.store(in: &subscriptions)
        locationManager.$locationPermission.sink { [weak self] permission in
            if permission == .denied {
                self?.shouldShowAlert = true
            } else {
                self?.shouldShowAlert = false
            }
        }.store(in: &subscriptions)
    }
    
    func fetchData(lat: Double, lon: Double) {
        Task { @MainActor in
           let data = await self.dataProvider.getAirQuality(lat: lat, lon: lon)
           self.pollutionData = data
        }
    }
    
    func getLocation() {
        do {
            try locationManager.getAuth()
        } catch {
            // error management
            print(error)
        }
    }
}
