//
//  PollutionDataProvider.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 07/12/2023.


import Foundation

class PollutionDataProvider {
    
    var airQualityResponse: AirQualityResponse?
    
    private func fetchPollutionData(lat: Double, lon: Double) async throws {
        //create the new url
        let url = URL(string: "http://api.openweathermap.org/data/2.5/air_pollution?lat&lon3&appid=27b3233fb194145bebbf28f441970661".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        //create a new urlRequest passing the url
        let request = URLRequest(url: url!)
        //run the request and retrieve both the data and the response of the call
        let (data, response) = try await URLSession.shared.data(for: request)
        //checks if there are errors regarding the HTTP status code and decodes using the passed struct
        airQualityResponse = try JSONDecoder().decode(AirQualityResponse.self, from: data)
    }
    
    func getAirQuality() async -> PollutionData? {
        do{
            try await fetchPollutionData(lat: 51.5, lon: 0.128)
        } catch {
           return nil
        }
        guard let response = airQualityResponse else { return nil}
        if response.coord.count != 2 || response.list.count != 1{
            return nil
        }
        let coord = Coordinates(latitude: response.coord[0], longitude: response.coord[1])
        let data = response.list[0]
        let pollutionData = PollutionData(coord: coord, time: data.dt, quality: data.components)
        return pollutionData
    }
}

struct AirQualityResponse: Decodable {
    let coord: [Double]
    let list: [DataList]
}

struct DataList: Decodable {
    let dt: String
    let components: AirQuality
}

