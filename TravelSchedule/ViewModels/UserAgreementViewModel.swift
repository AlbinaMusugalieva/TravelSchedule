//
//  UserAgreementViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import Foundation
import Combine

@MainActor final class UserAgreementViewModel: ObservableObject, Sendable {
    @Published var url: URL
    
    init(url: URL) {
        self.url = url
    }
}
