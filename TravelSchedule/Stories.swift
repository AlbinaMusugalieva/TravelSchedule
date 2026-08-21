//
//  Stories.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//
import Foundation
import SwiftUI

struct Stories: Identifiable {
    let id = UUID()
    let image: ImageResource
    let title: String
    var isWatched: Bool
}

var mockStories: [Stories] = [
    Stories(image: .stories1, title: "Text Text Text Text Text Text Text Text Text Text", isWatched: false),
    Stories(image: .stories2, title: "Text Text Text Text Text Text Text Text Text Text", isWatched: false),
    Stories(image: .stories3, title: "Text Text Text Text Text Text Text Text Text Text", isWatched: true),
    Stories(image: .stories4, title: "Text Text Text Text Text Text Text Text Text Text", isWatched: true)
]
