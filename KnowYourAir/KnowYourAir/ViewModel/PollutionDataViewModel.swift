//
//  DataViewModel.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 12/11/2023.
//

import Foundation


class PollutionDataViewModel: ObservableObject {
    @Published var pollutionData: PollutionData?
    
    private let dataProvider: PollutionDataProvider
    
    init(pollutionData: PollutionData?, dataProvider: PollutionDataProvider = PollutionDataProvider()) {
        self.pollutionData = pollutionData
        self.dataProvider = dataProvider
    }
    
    func fetchData(lat: Double = 51.5, lon: Double = 0.1) async {
        pollutionData = try await self.dataProvider.getAirQuality()
    }
}
