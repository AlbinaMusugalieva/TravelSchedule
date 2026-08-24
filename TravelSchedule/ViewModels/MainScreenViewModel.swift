//
//  MainScreenViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI
import Combine

@MainActor
final class MainScreenViewModel: ObservableObject {
    @Published var departureCity: String = ""
    @Published var departureStation: String = ""
    @Published var arrivalCity: String = ""
    @Published var arrivalStation: String = ""
    
    @Published var departureCode: String = ""
    @Published var arrivalCode: String = ""
    
    @Published var isShowingCitySelection = false
    @Published var isSelectingForSource = true
    @Published var stories: [Stories] = mockStories
    @Published var selectedStoryIndex: Int? = nil
    @Published var showStoriesFullscreen = false
    
    func swapDestinations() {
        let tempCity = departureCity
        let tempStation = departureStation
        let tempCode = departureCode
        
        departureCity = arrivalCity
        departureStation = arrivalStation
        departureCode = arrivalCode
        
        arrivalCity = tempCity
        arrivalStation = tempStation
        arrivalCode = tempCode
    }
    
    func selectStory(at index: Int) {
        selectedStoryIndex = index
        showStoriesFullscreen = true
        stories[index].isWatched = true
    }
}
