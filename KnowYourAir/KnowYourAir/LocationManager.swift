//
//  LocationManager.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 11/01/2024.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var location: CLLocation?


    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    func getAuth() throws {
        // Ask for Authorisation from the User.
       // self.locationManager.requestAlwaysAuthorization()
        if locationManager.authorizationStatus == .notDetermined {
            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
        }
        else {
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            default:
                // prompt alert (throw error)
                break
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        self.location = locations.last
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            // prompt alert (throw error)
            break
        }
    }
}
