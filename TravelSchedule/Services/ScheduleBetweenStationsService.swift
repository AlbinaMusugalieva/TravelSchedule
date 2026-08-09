//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleSegments = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol {
    func getSchedule(from: String, to: String) async throws -> ScheduleSegments
}

final class ScheduleBetweenStationsService: BaseService, ScheduleBetweenStationsServiceProtocol {
    func getSchedule(from: String, to: String) async throws -> ScheduleSegments {
        let response = try await client.getSchedualBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))
        
        return try response.ok.body.json
    }
}
