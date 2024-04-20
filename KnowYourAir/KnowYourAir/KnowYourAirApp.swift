//
//  KnowYourAirApp.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 11/11/2023.
//

import SwiftUI
import Combine

@main
struct KnowYourAirApp: App {
    private var locationManager = LocationManager()
    private var dataProvider = PollutionDataProvider()
    @Environment(\.scenePhase) private var scenePhase
    private var notificationHandler: NotificationHandler?
    
    init() {
        self.notificationHandler = NotificationHandler(locationManager: locationManager, dataProvider: dataProvider)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(dataProvider)
                .onChange(of: scenePhase) { _, newPhase in
                    switch newPhase {
                    case .background:
                        print("BACKGROUND!")
                        notificationHandler?.startObservingLocationUpdates()
                    case .active:
                        notificationHandler?.requestNotificationsPermissions()
                    default:
                        print("YOOOOOOO")
                        notificationHandler?.stopObservingLocationUpdates()
                    }
                }
        }
    }
}

class NotificationHandler {
    let locationManager: LocationManager
    let dataProvider: PollutionDataProvider
    private var locationBackgroundSubscription: AnyCancellable?
    
    init(locationManager: LocationManager, dataProvider: PollutionDataProvider) {
        self.locationManager = locationManager
        self.dataProvider = dataProvider
    }
    
    func requestNotificationsPermissions() {
        Task {
            let center = UNUserNotificationCenter.current()
            do {
                try await center.requestAuthorization(options: [.alert, .sound, .badge])
            } catch {
                // Handle the error here.
                print(error)
            }
        }
    }
    
    func startObservingLocationUpdates() {
        locationBackgroundSubscription = locationManager.$location
            .removeDuplicates()
            .dropFirst()
            .sink(receiveValue: { [weak self] newLocation in
                Task { [weak self] in
                    if let lat = newLocation?.coordinate.latitude, let lon = newLocation?.coordinate.longitude {
                        let airQuality = await self?.dataProvider.getAirQuality(lat: lat, lon: lon)?.airQuality.airQuality
                        self?.sendAirQualityNotification(airQuality: airQuality ?? .unKnown)
                    }
                }
            })
    }
    
    func sendAirQualityNotification(airQuality: AirQuality.AirQualityRank) {
        let content = UNMutableNotificationContent()
        content.title = "Air quality around your new location"
        content.body = airQuality.rawValue
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        Task {
            do {
                try await notificationCenter.add(request)
            } catch {
                print(error)
            }
        }
    }
    
    func stopObservingLocationUpdates() {
        locationBackgroundSubscription?.cancel()
    }
}
