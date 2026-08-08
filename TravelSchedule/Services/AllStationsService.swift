//
//  AllStationsService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations
}

final class AllStationsService: BaseService, AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(
            apikey: apikey
        ))
        
        switch response {
        case .ok(let okResponse):
            let responseBody = try okResponse.body.text_html_charset_utf_hyphen_8
            let limit = 50 * 1024 * 1024
            let fullData = try await Data(collecting: responseBody, upTo: limit)
            
            return try JSONDecoder().decode(AllStations.self, from: fullData)
            
        default:
            throw ServiceError.invalidResponse
        }
    }
}
