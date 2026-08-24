//
//  SettingsScreenView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct SettingsScreenView: View {
    @StateObject private var viewModel = SettingsScreenViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.ypWhite)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Toggle(isOn: $viewModel.isDarkMode) {
                        Text("Тёмная тема")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.ypBlack)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .tint(.ypBlueUniversal)
                    
                    Button {
                        viewModel.showAgreement = true
                    } label: {
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(.ypBlack)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(.ypBlack)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Приложение использует API «Яндекс.Расписания»")
                        Text("Версия 1.0 (beta)")
                    }
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlack)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)
                }
                .padding(.top, 16)
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.showAgreement) {
                if let url = viewModel.agreementURL {
                    UserAgreementView(url: url, isPresented: $viewModel.showAgreement)
                }
            }
        }
        .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
    }
}
