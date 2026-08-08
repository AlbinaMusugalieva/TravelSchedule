//
//  СopyrightService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightData = OpenAPIRuntime.OpenAPIObjectContainer

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightData
}

final class CopyrightService: BaseService, CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightData {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        
        return try response.ok.body.json
    }
}
