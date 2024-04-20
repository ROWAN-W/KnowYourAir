//
//  LocationManager.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 11/01/2024.
//

import Foundation
import CoreLocation
import Combine

enum LocationPermission{
    case granted
    case denied
    case unknown
}

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    var oldLocation: CLLocation?
    @Published var locationPermission: LocationPermission = .unknown

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
<<<<<<< Updated upstream
=======
        locationManager.allowsBackgroundLocationUpdates = true
>>>>>>> Stashed changes
    }

    func getAuth() throws {
        // Ask for Authorisation from the User.
       // self.locationManager.requestAlwaysAuthorization()
        if locationManager.authorizationStatus == .notDetermined {
            // For use in foreground
            self.locationPermission = .unknown
            self.locationManager.requestWhenInUseAuthorization()
        }
        else {
          changePermisionStatus()
        }
    }
    
    func changePermisionStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            self.locationPermission = .granted
        case .denied:
            self.locationPermission = .denied
        default:
            // prompt alert (throw error)
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.oldLocation = self.location
        self.location = locations.last
        print(self.location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        changePermisionStatus()
    }
}
