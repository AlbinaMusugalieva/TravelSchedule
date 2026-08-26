//
//  Stories.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//
import Foundation
import SwiftUI

struct Stories: Identifiable, Sendable {
    let id = UUID()
    let image: ImageResource
    let title: String
    var isWatched: Bool
}

@MainActor 
var mockStories: [Stories] = [
    Stories(image: .stories1, title: "Text Text Text Text Text Text Text Text Text Text", isWatched: false),
    Stories(image: .stories2, title: "Text Text Text Text Text Text Text Text Text Text", isWatched: false),
    Stories(image: .stories3, title: "Text Text Text Text Text Text Text Text Text Text", isWatched: true),
    Stories(image: .stories4, title: "Text Text Text Text Text Text Text Text Text Text", isWatched: true)
]

struct Station: Identifiable, Sendable, Hashable {
    let id = UUID()
    let name: String
    let code: String
}


struct City: Identifiable, Sendable {
    let id = UUID()
    let name: String
    let code: String
    let stations: [Station] 
}

struct TrainTrip: Identifiable, Sendable {
    let id = UUID()
    let carrierName: String
    let logoImage: ImageResource
    let transferText: String?
    let dateText: String
    let departureTime: String
    let durationText: String
    let arrivalTime: String
    
    let carrierCode: String
}
