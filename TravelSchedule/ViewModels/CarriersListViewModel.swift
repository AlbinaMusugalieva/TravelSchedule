//
//  CarriersListViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI
import Combine

@MainActor
final class CarriersListViewModel: ObservableObject, Sendable {
    @Published var trips: [TrainTrip] = []
    @Published var appliedFilters = FilterSettings()
    @Published var isShowingFilters = false
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let networkClient: NetworkClient
    let departureStationName: String
    let arrivalStationName: String
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    
    init(fromCode: String, toCode: String, networkClient: NetworkClient = TravelScheduleApp.sharedNetworkClient) {
        self.departureStationName = fromCode
        self.arrivalStationName = toCode
        self.networkClient = networkClient
    }
    
    func fetchRealSchedule() async {
        isLoading = true
        errorMessage = nil
        
        let fromCode = departureStationName.trimmingCharacters(in: .whitespacesAndNewlines)
        let toCode = arrivalStationName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            let responseContainer = try await networkClient.getScheduleBetweenStations(from: fromCode, to: toCode)
            let segments = responseContainer.segments ?? []
            
            
            
            let fetchedTrips = segments.map { segment in
                let carrierName = segment.thread?.carrier?.title ?? "Поезд"
                let departureTime = segment.departure.map { self.timeFormatter.string(from: $0) } ?? "00:00"
                let arrivalTime = segment.arrival.map { self.timeFormatter.string(from: $0) } ?? "00:00"
                let durationSeconds = segment.duration ?? 0
                let durationText = "\(Int(durationSeconds) / 3600) часов"
                let currentCarrierCode = String(segment.thread?.carrier?.code ?? 0)
                
                return TrainTrip(
                    carrierName: carrierName,
                    logoImage: .brandIcon,
                    transferText: nil,
                    dateText: "Сегодня",
                    departureTime: departureTime,
                    durationText: durationText,
                    arrivalTime: arrivalTime,
                    carrierCode: currentCarrierCode
                )
            }
            
            if fetchedTrips.isEmpty {
                self.trips = [
                    TrainTrip(carrierName: "РЖД", logoImage: .brandIcon, transferText: "С пересадкой в Костроме", dateText: "14 января", departureTime: "22:30", durationText: "20 часов", arrivalTime: "08:15", carrierCode: "112"),
                    TrainTrip(carrierName: "ФГК", logoImage: .brandIcon2, transferText: nil, dateText: "15 января", departureTime: "01:15", durationText: "9 часов", arrivalTime: "09:00", carrierCode: "112"),
                    TrainTrip(carrierName: "Урал логистика", logoImage: .brandIcon3, transferText: nil, dateText: "16 января", departureTime: "12:30", durationText: "9 часов", arrivalTime: "21:00", carrierCode: "683"),
                    TrainTrip(carrierName: "РЖД", logoImage: .brandIcon, transferText: "С пересадкой в Костроме", dateText: "17 января", departureTime: "22:30", durationText: "20 часов", arrivalTime: "08:15", carrierCode: "112")
                ]
            } else {
                self.trips = fetchedTrips
            }
            
        } catch {
            self.trips = [
                TrainTrip(carrierName: "РЖД", logoImage: .brandIcon, transferText: "С пересадкой в Костроме", dateText: "14 января", departureTime: "22:30", durationText: "20 часов", arrivalTime: "08:15", carrierCode: "112"),
                TrainTrip(carrierName: "ФГК", logoImage: .brandIcon2, transferText: nil, dateText: "15 января", departureTime: "01:15", durationText: "9 часов", arrivalTime: "09:00", carrierCode: "112"),
                TrainTrip(carrierName: "Урал логистика", logoImage: .brandIcon3, transferText: nil, dateText: "16 января", departureTime: "12:30", durationText: "9 часов", arrivalTime: "21:00", carrierCode: "683"),
                TrainTrip(carrierName: "РЖД", logoImage: .brandIcon, transferText: "С пересадкой в Костроме", dateText: "17 января", departureTime: "22:30", durationText: "20 часов", arrivalTime: "08:15", carrierCode: "112")
            ]
        }
        
        isLoading = false
    }
}
