//
//  CarrierInfoService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import OpenAPIRuntime

typealias CarrierData = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String) async throws -> CarrierData
}

final class CarrierInfoService: BaseService, CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String) async throws -> CarrierData {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code
        ))
        
        return try response.ok.body.json
    }
}
