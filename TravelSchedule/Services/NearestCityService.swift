//
//  NearestCityService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import OpenAPIRuntime

typealias NearestCityData = Components.Schemas.NearestCityResponse

protocol NearestCityServiceProtocol {
    func getNearestCity(lat: Double, lng: Double) async throws -> NearestCityData
}

final class NearestCityService: BaseService, NearestCityServiceProtocol {
    func getNearestCity(lat: Double, lng: Double) async throws -> NearestCityData {
        let response = try await client.getNearestCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng
        ))
        
        return try response.ok.body.json
    }
}
