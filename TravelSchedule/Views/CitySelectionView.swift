//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct CitySelectionView: View {
    @Binding var isPresented: Bool
    var onSelect: (String, String) -> Void
    @State private var searchText: String = ""
    
    let cities = ["Москва", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    
    var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.ypBlack)
                    }
                    
                    Spacer()
                    
                    Text("Выбор города")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.ypBlack)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .opacity(0)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.ypGreyUniversal)
                    
                    TextField("Введите запрос", text: $searchText)
                        .font(.system(size: 16))
                        .foregroundColor(.ypBlack)
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.ypGreyUniversal)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .frame(height: 36)
                .background(.ypLightGray)
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
                if filteredCities.isEmpty {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(filteredCities, id: \.self) { city in
                                NavigationLink(destination: StationSelectionView(
                                    cityName: city,
                                    isRootPresented: $isPresented,
                                    onSelectStation: { selectedStation in
                                        onSelect(city, selectedStation)
                                    }
                                )) {
                                    HStack {
                                        Text(city)
                                            .font(.system(size: 17, weight: .regular))
                                            .foregroundColor(.ypBlack)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.ypBlack)
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 54)
                                    .contentShape(Rectangle())
                                }
                                
                                Divider()
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
            .background(.ypWhite)
        }
    }
}
