//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
