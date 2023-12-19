//
//  PollutionDataProvider.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 07/12/2023.
//

import Foundation

class PollutionDataProvider {
    func fetchPollutionData() async throws -> AirQuality {
        //create the new url
        let url = URL(string: "http://api.openweathermap.org/data/2.5/air_pollution?lat=51.5&lon=0.13&appid=27b3233fb194145bebbf28f441970661".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        //create a new urlRequest passing the url
        let request = URLRequest(url: url!)
        //run the request and retrieve both the data and the response of the call
        let (data, response) = try await URLSession.shared.data(for: request)
        
        return AirQuality()
    }
}

