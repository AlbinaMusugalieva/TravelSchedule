//
//  StationSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI
import Combine

@MainActor
final class StationSelectionViewModel: ObservableObject, Sendable {
    @Published var searchText: String = ""
    
    let city: City
    
    init(city: City) {
        self.city = city
    }
    
    var filteredStations: [Station] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else {
            return city.stations
        }
        return city.stations.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}
