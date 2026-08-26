//
//  MainScreenViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI
import Combine

@MainActor
final class MainScreenViewModel: ObservableObject, Sendable {
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
    
    func selectStation(_ station: Station) {
            if isSelectingForSource {
                departureStation = station.name
                departureCode = station.code
                
                if station.code == "s9602494" || station.code == "s9602554" {
                    departureCity = "Санкт-Петербург"
                } else if station.code == "s9613143" {
                    departureCity = "Сочи"
                } else if station.code == "s9613123" {
                    departureCity = "Краснодар"
                } else if station.code == "s9610011" {
                    departureCity = "Казань"
                } else {
                    departureCity = "Москва"
                }
            } else {
                arrivalStation = station.name
                arrivalCode = station.code
                
                if station.code == "s9602494" || station.code == "s9602554" {
                    arrivalCity = "Санкт-Петербург"
                } else if station.code == "s9613143" {
                    arrivalCity = "Сочи"
                } else if station.code == "s9613123" {
                    arrivalCity = "Краснодар"
                } else if station.code == "s9610011" {
                    arrivalCity = "Казань"
                } else {
                    arrivalCity = "Москва"
                }
            }
        }
}
