//
//  FiltersViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//
import SwiftUI
import Combine

@MainActor final class FiltersViewModel: ObservableObject, Sendable {
    @Published var isMorning: Bool = false
    @Published var isAfternoon: Bool = false
    @Published var isEvening: Bool = false
    @Published var isNight: Bool = false
    @Published var showWithTransfers: Bool? = nil
    private let onApply: @Sendable (FilterSettings) -> Void
    var isAnyFilterSelected: Bool {
        isMorning || isAfternoon || isEvening || isNight || (showWithTransfers != nil)
    }
    init(initialFilters: FilterSettings, onApply: @escaping @Sendable (FilterSettings) -> Void) {
        self.onApply = onApply
        setupInitialFilters(initialFilters)
    }
    func setupInitialFilters(_ filters: FilterSettings) {
        self.isMorning = filters.isMorning
        self.isAfternoon = filters.isAfternoon
        self.isEvening = filters.isEvening
        self.isNight = filters.isNight
        self.showWithTransfers = filters.showWithTransfers
    }
    func applyFilters() {
        let updatedFilters = FilterSettings(
            isMorning: isMorning,
            isAfternoon: isAfternoon,
            isEvening: isEvening,
            isNight: isNight,
            showWithTransfers: showWithTransfers
        )
        onApply(updatedFilters)
    }
    func selectTransfers(_ value: Bool) {
        showWithTransfers = value
    }
}
