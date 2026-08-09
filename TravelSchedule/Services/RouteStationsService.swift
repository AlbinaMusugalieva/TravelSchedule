//
//  RouteStationsService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import OpenAPIRuntime

typealias RouteStationsData = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtocol {
    func getRouteStations(uid: String) async throws -> RouteStationsData
}

final class RouteStationsService: BaseService, RouteStationsServiceProtocol {
    func getRouteStations(uid: String) async throws -> RouteStationsData {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid
        ))
        
        return try response.ok.body.json
    }
}
