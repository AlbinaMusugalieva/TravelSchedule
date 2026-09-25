//
//  NetworkClient.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import Foundation
import OpenAPIRuntime

actor NetworkClient: Sendable {
    private let copyrightService: CopyrightServiceProtocol & Sendable
    private let allStationsService: AllStationsServiceProtocol & Sendable
    private let carrierInfoService: CarrierInfoServiceProtocol & Sendable
    private let nearestCityService: NearestCityServiceProtocol & Sendable
    private let nearestStationsService: NearestStationsServiceProtocol & Sendable
    private let routeStationsService: RouteStationsServiceProtocol & Sendable
    private let scheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol & Sendable
    private let stationScheduleService: StationScheduleServiceProtocol & Sendable
    
    init(
        copyrightService: CopyrightServiceProtocol & Sendable,
        allStationsService: AllStationsServiceProtocol & Sendable,
        carrierInfoService: CarrierInfoServiceProtocol & Sendable,
        nearestCityService: NearestCityServiceProtocol & Sendable,
        nearestStationsService: NearestStationsServiceProtocol & Sendable,
        routeStationsService: RouteStationsServiceProtocol & Sendable,
        scheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol & Sendable,
        stationScheduleService: StationScheduleServiceProtocol & Sendable
    ) {
        self.copyrightService = copyrightService
        self.allStationsService = allStationsService
        self.carrierInfoService = carrierInfoService
        self.nearestCityService = nearestCityService
        self.nearestStationsService = nearestStationsService
        self.routeStationsService = routeStationsService
        self.scheduleBetweenStationsService = scheduleBetweenStationsService
        self.stationScheduleService = stationScheduleService
    }
    
    func getCopyright() async throws -> CopyrightData {
        try await copyrightService.getCopyright()
    }
    
    func getAllStations() async throws -> AllStations {
        try await allStationsService.getAllStations()
    }
    
    func getCarrierInfo(code: String) async throws -> CarrierData {
        try await carrierInfoService.getCarrierInfo(code: code)
    }
    
    func getNearestCity(lat: Double, lng: Double) async throws -> NearestCityData {
        try await nearestCityService.getNearestCity(lat: lat, lng: lng)
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        try await nearestStationsService.getNearestStations(lat: lat, lng: lng, distance: distance)
    }
    
    func getRouteStations(uid: String) async throws -> RouteStationsData {
        try await routeStationsService.getRouteStations(uid: uid)
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleSegments {
        try await scheduleBetweenStationsService.getSchedule(from: from, to: to)
    }
    
    func getStationSchedule(station: String) async throws -> StationScheduleData {
        try await stationScheduleService.getSchedule(station: station)
    }
    
    func getCitiesCatalog() async throws -> [City] {
        try? await Task.sleep(for: .milliseconds(300))
        
        return [
            City(name: "Москва", code: "c213", stations: [
                Station(name: "Ленинградский вокзал", code: "s9600213"),
                Station(name: "Курский вокзал", code: "s9600193"),
                Station(name: "Ярославский вокзал", code: "s9601721"),
                Station(name: "Казанский вокзал", code: "s9601753")
            ]),
            City(name: "Санкт-Петербург", code: "c2", stations: [
                Station(name: "Московский вокзал", code: "s9602494"),
                Station(name: "Балтийский вокзал", code: "s9602554")
            ]),
            City(name: "Сочи", code: "c239", stations: [
                Station(name: "Станция Сочи", code: "s9613143")
            ]),
            City(name: "Краснодар", code: "c35", stations: [
                Station(name: "Краснодар-1", code: "s9613123")
            ]),
            City(name: "Казань", code: "c43", stations: [
                Station(name: "Казань-Пассажирская", code: "s9610011")
            ])
        ]
    }
}

extension Components.Schemas.Segment {
    @MainActor
     func toTrainTrip() -> TrainTrip {
        let carrierName = self.thread?.carrier?.title ?? "Перевозчик"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let departureTime = self.departure.map { timeFormatter.string(from: $0) } ?? "00:00"
        let arrivalTime = self.arrival.map { timeFormatter.string(from: $0) } ?? "00:00"
        
        let durationSeconds = self.duration ?? 0
        let durationText = "\(Int(durationSeconds) / 3600) часов"
        
        let transferText: String? = nil
        
        let currentCarrierCode = String(self.thread?.carrier?.code ?? 0)
        
        return TrainTrip(
            carrierName: carrierName,
            logoImage: .brandIcon,
            transferText: transferText,
            dateText: "Сегодня",
            departureTime: departureTime,
            durationText: durationText,
            arrivalTime: arrivalTime,
            carrierCode: currentCarrierCode
        )
    }
}
