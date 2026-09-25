//
//  MainTabViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import Foundation
import OpenAPIURLSession
import Combine

@MainActor
final class MainTabViewModel: ObservableObject, Sendable {
    @Published var networkState: AppNetworkState = .normal
    
    func resetNetworkState() {
        networkState = .normal
    }
    
    func checkNetworkServices() async {
        guard let serverURL = try? Servers.Server1.url() else {
            print("Не удалось получить URL сервера")
            return
        }
        
        let sharedClient = Client(serverURL: serverURL, transport: URLSessionTransport())
        let apiKey = Constants.apiKey
        
        let copyrightService = CopyrightService(client: sharedClient, apikey: apiKey)
        let nearestStationsService = NearestStationsService(client: sharedClient, apikey: apiKey)
        let scheduleBetweenStationsService = ScheduleBetweenStationsService(client: sharedClient, apikey: apiKey)
        let stationScheduleService = StationScheduleService(client: sharedClient, apikey: apiKey)
        let routeStationsService = RouteStationsService(client: sharedClient, apikey: apiKey)
        let nearestCityService = NearestCityService(client: sharedClient, apikey: apiKey)
        let carrierInfoService = CarrierInfoService(client: sharedClient, apikey: apiKey)
        let allStationsService = AllStationsService(client: sharedClient, apikey: apiKey)
        
        Task.detached {
            do { _ = try await copyrightService.getCopyright(); print("СopyrightService loaded successfully") } catch { print("CopyrightService error: \(error.localizedDescription)") }
            do { _ = try await nearestStationsService.getNearestStations(lat: 55.75, lng: 37.61, distance: 10); print("NearestStationsService loaded successfully") } catch { print("NearestStationsService error: \(error.localizedDescription)") }
            do { _ = try await scheduleBetweenStationsService.getSchedule(from: "c213", to: "c2"); print("ScheduleBetweenStationsService loaded successfully") } catch { print("ScheduleBetweenStationsService error: \(error.localizedDescription)") }
            do { _ = try await stationScheduleService.getSchedule(station: "s9600213"); print("StationScheduleService loaded successfully") } catch { print("StationScheduleService error: \(error.localizedDescription)") }
            do { _ = try await routeStationsService.getRouteStations(uid: "123"); print("RouteStationsService loaded successfully") } catch { print("RouteStationsService error: \(error.localizedDescription)") }
            do { _ = try await nearestCityService.getNearestCity(lat: 55.75, lng: 37.61); print("NearestCityService loaded successfully") } catch { print("NearestCityService error: \(error.localizedDescription)") }
            do { _ = try await carrierInfoService.getCarrierInfo(code: "123"); print("CarrierInfoService loaded successfully") } catch { print("CarrierInfoService error: \(error.localizedDescription)") }
            do { _ = try await allStationsService.getAllStations(); print("AllStationsService loaded successfully") } catch { print("AllStationsService error: \(error.localizedDescription)") }
        }
    }
}
