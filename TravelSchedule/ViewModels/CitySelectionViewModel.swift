//
//  CitySelectionViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//
import SwiftUI
import Combine

enum ScreenState {
    case loading
    case content
    case error
}

@MainActor
final class CitySelectionViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var cities: [City] = []
    @Published var screenState: ScreenState = .loading
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = TravelScheduleApp.sharedNetworkClient) {
        self.networkClient = networkClient
    }
    
    var filteredCities: [City] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else {
            return cities
        }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
    
    func loadCities() async {
        screenState = .loading
        do {
            let loadedCities = try await networkClient.getCitiesCatalog()
            self.cities = loadedCities
            self.screenState = .content
        } catch {
            if error is CancellationError { return }
            self.screenState = .error
        }
    }
}
