//
//  PollutionDataProvider.swift
//  KnowYourAir
//
//  Created by ROWAN WANG on 07/12/2023.


import Foundation
import CoreLocation

enum Endpoint {
    case airPollution(CLLocation)

    var baseURLString: String { "http://api.openweathermap.org/data" }

    var version: String { "/2.5" }

    var method: String {
        switch self {
        case .airPollution:
            "GET"
        }
    }

    var resource: String {
        switch self {
        case .airPollution:
            return "/air_pollution"
        }
    }

    var queryParameters: [String: String] {
        var params = ["appid": "27b3233fb194145bebbf28f441970661"]
        switch self {
        case let .airPollution(location):
            params["lat"] = "\(location.coordinate.latitude)"
            params["lon"] = "\(location.coordinate.longitude)"
        }
        return params
    }
}

class HTTPClient {
    enum HTTPRequestError: Error {
        case invalidURLFormat
    }

    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch(endpoint: Endpoint) async throws -> Data {
        do {
            var urlComponents = URLComponents(string: endpoint.baseURLString + endpoint.version + endpoint.resource)
            if !endpoint.queryParameters.isEmpty {
                urlComponents?.queryItems = endpoint.queryParameters.map({ (key, value) in
                    return URLQueryItem(name: key, value: value)
                })
            }
            guard let url = urlComponents?.url else {
                throw HTTPRequestError.invalidURLFormat
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endpoint.method
            let (data, _) = try await session.data(for: urlRequest)
            return data
        } catch {
            print(error)
            throw error
        }
    }
}

class PollutionDataProvider: ObservableObject {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    private func fetchPollutionData(lat: Double, lon: Double) async -> AirQualityResponse? {
        do {
            let data = try await httpClient.fetch(endpoint: .airPollution(CLLocation(latitude: lat, longitude: lon)))
            return try JSONDecoder().decode(AirQualityResponse.self, from: data)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func getAirQuality(lat: Double, lon: Double) async -> PollutionData? {
        guard let response = await fetchPollutionData(lat: lat, lon: lon) else { return nil}
        if response.list.count != 1{
            return nil
        }
        let data = response.list[0]
        let pollutionData = PollutionData(coord: response.coord, time: data.dt, airQuality: data.components)
        return pollutionData
    }
}

struct AirQualityResponse: Decodable {
    let coord: Coordinates
    let list: [DataList]
}

struct DataList: Decodable {
    let dt: TimeInterval
    let components: AirQuality
}

