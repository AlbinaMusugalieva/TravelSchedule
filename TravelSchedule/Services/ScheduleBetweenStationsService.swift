//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias ScheduleSegments = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol {
    func getSchedule(from: String, to: String) async throws -> ScheduleSegments
}

final class ScheduleBetweenStationsService: BaseService, ScheduleBetweenStationsServiceProtocol {
    func getSchedule(from: String, to: String) async throws -> ScheduleSegments {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: Date())
        
        let targetDate: Date
        if currentHour >= 21 || currentHour < 6 {
            targetDate = calendar.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        } else {
            targetDate = Date()
        }
        
        let dateString = formatter.string(from: targetDate)
        
        let response = try await client.getSchedualBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            format: "json",
            lang: "ru_RU",
            date: dateString, 
            transport_types: "train",
            offset: 0,
            limit: 100,
            result_timezone: nil,
            transfers: false
        ))
        
        return try response.ok.body.json
    }
}
