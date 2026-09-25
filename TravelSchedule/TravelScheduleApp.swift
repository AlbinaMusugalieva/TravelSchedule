//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    static let sharedNetworkClient: NetworkClient = {
        guard let serverURL = try? Servers.Server1.url() else {
            fatalError("Не удалось получить URL сервера")
        }
        
        let sharedClient = Client(serverURL: serverURL, transport: URLSessionTransport())
        let apiKey = Constants.apiKey
        
        return NetworkClient(
            copyrightService: CopyrightService(client: sharedClient, apikey: apiKey),
            allStationsService: AllStationsService(client: sharedClient, apikey: apiKey),
            carrierInfoService: CarrierInfoService(client: sharedClient, apikey: apiKey),
            nearestCityService: NearestCityService(client: sharedClient, apikey: apiKey),
            nearestStationsService: NearestStationsService(client: sharedClient, apikey: apiKey),
            routeStationsService: RouteStationsService(client: sharedClient, apikey: apiKey),
            scheduleBetweenStationsService: ScheduleBetweenStationsService(client: sharedClient, apikey: apiKey),
            stationScheduleService: StationScheduleService(client: sharedClient, apikey: apiKey)
        )
    }()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
