//
//  DataViewModel.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 12/11/2023.
//

import Foundation
import Combine
import BackgroundTasks

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
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.rowan.KnowYourAir.userMoveRefresh", using: nil) { task in
//            self.handleAppRefresh(task: task as! BGAppRefreshTask)
//        }
    }
//    
//    func handleAppRefresh(task: BGAppRefreshTask) {
//        // Schedule a new refresh task.
//        scheduleAppRefresh()
//        
//        // Create an operation that performs the main part of the background task.
//        let operation =
//        
//        // Provide the background task with an expiration handler that cancels the operation.
//        task.expirationHandler = {
//            operation.cancel()
//        }
//        
//        
//        // Inform the system that the background task is complete
//        // when the operation completes.
//        operation.completionBlock = {
//            task.setTaskCompleted(success: !operation.isCancelled)
//        }
//        
//        
//        // Start the operation.
//        operationQueue.addOperation(operation)
//    }
    
    func scheduleAppRefresh() {
       let request = BGAppRefreshTaskRequest(identifier: "com.rowan.KnowYourAir.userMoveRefresh")
       // Fetch no earlier than 15 minutes from now.
       request.earliestBeginDate = Date(timeIntervalSinceNow: 60)
            
       do {
          try BGTaskScheduler.shared.submit(request)
       } catch {
          print("Could not schedule app refresh: \(error)")
       }
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
