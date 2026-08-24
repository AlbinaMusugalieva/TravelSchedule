//
//  CarrierDetailViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//
import SwiftUI
import Combine

@MainActor
final class CarrierDetailViewModel: ObservableObject {
    @Published var carrierName: String = "Загрузка..."
    @Published var carrierEmail: String = "—"
    @Published var carrierPhone: String = "—"
    @Published var isLoading = false
    
    private let networkClient: NetworkClient
    private let carrierCode: String
    
    init(carrierCode: String, networkClient: NetworkClient = TravelScheduleApp.sharedNetworkClient) {
        self.carrierCode = carrierCode
        self.networkClient = networkClient
    }
    
    func fetchCarrierDetails(defaultName: String) async {
            isLoading = true
            do {
                let response = try await networkClient.getCarrierInfo(code: self.carrierCode)
                let carriersList = response.carriers ?? []
                
                if let carrier = carriersList.first {
                    self.carrierName = carrier.title ?? defaultName
                    self.carrierEmail = carrier.email ?? "info@rjd.ru"
                    self.carrierPhone = carrier.phone ?? "+7 (800) 775-00-00"
                } else {
                    self.carrierName = defaultName
                    setupMockContacts(for: defaultName)
                }
            } catch {
                print("Ошибка загрузки деталей перевозчика: \(error.localizedDescription)")
                self.carrierName = defaultName
                setupMockContacts(for: defaultName)
            }
            isLoading = false
        }
        
        private func setupMockContacts(for name: String) {
            if name.contains("Урал") {
                self.carrierEmail = "ural.logistics@ural.ru"
                self.carrierPhone = "+7 (343) 111-22-33"
            } else if name.contains("ФГК") {
                self.carrierEmail = "info@fgk.ru"
                self.carrierPhone = "+7 (495) 777-88-99"
            } else {
                self.carrierEmail = "ticket@rzd.ru"
                self.carrierPhone = "+7 (800) 775-00-00"
            }
        }
}
