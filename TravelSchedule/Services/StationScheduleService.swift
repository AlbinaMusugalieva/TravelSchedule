//
//  StationScheduleService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import OpenAPIRuntime

typealias StationScheduleData = Components.Schemas.ScheduleResponse

protocol StationScheduleServiceProtocol {
    func getSchedule(station: String) async throws -> StationScheduleData
}

final class StationScheduleService: BaseService, StationScheduleServiceProtocol {
    func getSchedule(station: String) async throws -> StationScheduleData {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station
        ))
        return try response.ok.body.json
    }
}
