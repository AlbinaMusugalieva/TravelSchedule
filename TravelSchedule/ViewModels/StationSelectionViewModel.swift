//
//  StationSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI
import Combine

@MainActor
final class StationSelectionViewModel: ObservableObject {
    @Published var searchText: String = ""

    let stations = [
        "Курский вокзал",
        "Балтийский вокзал",
        "Ленинградский вокзал",
        "Московский вокзал",
        "Ярославский вокзал",
        "Казанский вокзал"
    ]
    
    var filteredStations: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
