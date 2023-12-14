//
//  MapViewModel.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 12/11/2023.
//

import Foundation
import CoreLocation

class MapViewModel {
    let monitor: CLMonitor
    
    init() async {
        self.monitor = await CLMonitor("Greeter")
    }
    
}




