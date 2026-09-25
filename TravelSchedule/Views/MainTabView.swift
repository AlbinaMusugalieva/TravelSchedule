//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

enum AppNetworkState {
    case normal
    case noInternet
    case serverError
}

@MainActor
struct MainTabView: View {
    @StateObject private var viewModel = MainTabViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                NavigationStack {
                    MainScreenView(networkState: $viewModel.networkState)
                }
                .tabItem {
                    Image(.arrowUpMessageFill)
                }
                
                SettingsScreenView()
                    .tabItem {
                        Image(.settingsLogo)
                    }
            }
            
            if viewModel.networkState != .normal {
                errorOverlayView
            }
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color(.ypGreyUniversal))
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.label
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 20)
            appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 20)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .task {
            await viewModel.checkNetworkServices()
        }
    }
    
    @ViewBuilder
    private var errorOverlayView: some View {
        switch viewModel.networkState {
        case .noInternet:
            StatusErrorView(
                imageResource: .noInternet,
                message: "Нет интернета"
            )
            .onTapGesture {
                viewModel.resetNetworkState()
            }
        case .serverError:
            StatusErrorView(
                imageResource: .serverError,
                message: "Ошибка сервера"
            )
            .onTapGesture {
                viewModel.resetNetworkState()
            }
        default:
            EmptyView()
        }
    }
}
