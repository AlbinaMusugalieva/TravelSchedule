//
//  MainScreenView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct MainScreenView: View {
    @Binding var networkState: AppNetworkState
    
    @State private var departureCity: String = ""
    @State private var departureStation: String = ""
    @State private var arrivalCity: String = ""
    @State private var arrivalStation: String = ""
    @State private var isShowingCitySelection = false
    @State private var isSelectingForSource = true
    
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Spacer()
                    .frame(height: 140)
                HStack(spacing: 12) {
                    VStack(spacing: 0) {
                        MainInputRow(
                            placeholder: "Откуда",
                            city: departureCity,
                            station: departureStation
                        ) {
                            isSelectingForSource = true
                            isShowingCitySelection = true
                        }
                        
                        MainInputRow(
                            placeholder: "Куда",
                            city: arrivalCity,
                            station: arrivalStation
                        ) {
                            isSelectingForSource = false
                            isShowingCitySelection = true
                        }
                    }
                    .background(.ypWhite)
                    .cornerRadius(20)
                    
                    Button(action: swapDestinations) {
                        ZStack {
                            Circle()
                                .fill(.ypWhite)
                                .frame(width: 36, height: 36)
                            
                            Image(systemName: "arrow.2.squarepath")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.ypBlueUniversal)
                        }
                    }
                    .padding(.trailing, 4)
                }
                .padding(16)
                .background(.ypBlueUniversal)
                .cornerRadius(24)
                .padding(.horizontal, 16)
                
                if !departureCity.isEmpty && !arrivalCity.isEmpty {
                    NavigationLink(destination: CarriersListView(
                        networkState: $networkState,
                        departureCity: departureCity,
                        departureStation: departureStation,
                        arrivalCity: arrivalCity,
                        arrivalStation: arrivalStation
                    )) {
                        Text("Найти")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.ypWhite)
                            .frame(width: 150, height: 48)
                            .background(.ypBlueUniversal)
                            .cornerRadius(16)
                    }
                    .padding(.top, 24)
                }
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $isShowingCitySelection) {
            CitySelectionView(isPresented: $isShowingCitySelection) { selectedCity, selectedStation in
                if isSelectingForSource {
                    departureCity = selectedCity
                    departureStation = selectedStation
                } else {
                    arrivalCity = selectedCity
                    arrivalStation = selectedStation
                }
            }
        }
    }
    
    private func swapDestinations() {
        let tempCity = departureCity
        let tempStation = departureStation
        
        departureCity = arrivalCity
        departureStation = arrivalStation
        
        arrivalCity = tempCity
        arrivalStation = tempStation
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
                            .foregroundColor(.ypGreyUniversal)
                    } else {
                        Group {
                            if station.isEmpty {
                                Text(city)
                            } else {
                                Text("\(city) (\(station))")
                            }
                        }
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.ypBlack)
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
