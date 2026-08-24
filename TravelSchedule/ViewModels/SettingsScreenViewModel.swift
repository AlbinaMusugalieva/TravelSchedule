//
//  SettingsScreenViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI
import Combine

@MainActor
final class SettingsScreenViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = false
    @Published var showAgreement = false
    
    @Published var agreementURL: URL?
    
    init() {
        let urlString = "https://yandex.ru/legal/practicum_offer/"
        
        guard let validURL = URL(string: urlString) else {
            print("ОШИБКА: Не удалось создать валидный URL из строки \(urlString)")
            return
        }
        self.agreementURL = validURL
    }
}
