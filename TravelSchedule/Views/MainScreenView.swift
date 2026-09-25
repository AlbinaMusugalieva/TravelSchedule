//
//  MainScreenView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

@MainActor
struct MainScreenView: View {
    @Binding var networkState: AppNetworkState
    @StateObject private var viewModel = MainScreenViewModel()
    
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<viewModel.stories.count, id: \.self) { index in
                            StoryCell(stories: viewModel.stories[index])
                                .onTapGesture {
                                    viewModel.selectStory(at: index)
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        VStack(spacing: 0) {
                            MainInputRow(
                                placeholder: "Откуда",
                                city: viewModel.departureCity,
                                station: viewModel.departureStation
                            ) {
                                viewModel.isSelectingForSource = true
                                viewModel.isShowingCitySelection = true
                            }
                            
                            MainInputRow(
                                placeholder: "Куда",
                                city: viewModel.arrivalCity,
                                station: viewModel.arrivalStation
                            ) {
                                viewModel.isSelectingForSource = false
                                viewModel.isShowingCitySelection = true
                            }
                        }
                        .background(.ypWhiteUniversal)
                        .cornerRadius(20)
                        
                        Button(action: viewModel.swapDestinations) {
                            ZStack {
                                Circle()
                                    .fill(.ypWhiteUniversal)
                                    .frame(width: 36, height: 36)
                                
                                Image(systemName: "arrow.2.squarepath")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.ypBlueUniversal)
                            }
                        }
                        .padding(.trailing, 4)
                    }
                    .padding(16)
                    .background(.ypBlueUniversal)
                    .cornerRadius(24)
                    .padding(.horizontal, 16)
                    if !viewModel.departureCity.isEmpty && !viewModel.arrivalCity.isEmpty {
                        NavigationLink(destination: CarriersListView(
                            networkState: $networkState,
                            departureCity: viewModel.departureCity,
                            departureStation: viewModel.departureStation,
                            departureCode: viewModel.departureCode,
                            arrivalCity: viewModel.arrivalCity,
                            arrivalStation: viewModel.arrivalStation,
                            arrivalCode: viewModel.arrivalCode
                        )) {
                            Text("Найти")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.ypWhite)
                                .frame(width: 150, height: 48)
                                .background(.ypBlueUniversal)
                                .cornerRadius(16)
                        }
                        .padding(.top, 24)
                    }
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $viewModel.isShowingCitySelection) {
                CitySelectionView(isPresented: $viewModel.isShowingCitySelection) { @Sendable station in
                    Task {
                        await MainActor.run {
                            viewModel.selectStation(station)
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $viewModel.showStoriesFullscreen) {
                if let index = viewModel.selectedStoryIndex {
                    StoriesFullscreenView(stories: $viewModel.stories, currentIndex: index)
                }
            }
        }
    }
    
    struct MainInputRow: View {
        let placeholder: String
        let city: String
        let station: String
        let onTap: () -> Void
        
        var body: some View {
            Button(action: onTap) {
                HStack {
                    if city.isEmpty {
                        Text(placeholder)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.ypGreyUniversal)
                    } else {
                        Group {
                            Text(station.isEmpty ? city : "\(city) (\(station))")
                        }
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.ypBlackUniversal)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .frame(height: 48)
            }
        }
    }
}
