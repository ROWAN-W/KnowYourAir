//
//  LocationManager.swift
//  KnowYourAir
//
//  Created by 王子润 on 11/01/2024.
//

import Foundation
import CoreLocation

class LocationManager: CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    
    init() {
    }
    
    func getAuth() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self.locationManager
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
}
