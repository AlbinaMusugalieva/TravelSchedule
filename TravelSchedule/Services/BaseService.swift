//
//  BaseService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//
import OpenAPIRuntime
import OpenAPIURLSession

enum ServiceError: Error {
    case invalidResponse
}

class BaseService: Sendable {
    let client: Client
    let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
}
