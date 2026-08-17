//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct StationSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    let cityName: String
    
    @Binding var isRootPresented: Bool
    var onSelectStation: (String) -> Void
    
    @State private var searchText: String = ""
    
    let stations = [
        "Курский вокзал",
        "Балтийский вокзал",
        "Ленинградский вокзал",
        "Московский вокзал",
        "Ярославский вокзал",
        "Казанский вокзал"
    ]
    
    var filteredStations: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.ypBlack)
                }
                
                Spacer()
                
                Text("Выбор вокзала")
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
            
            if filteredStations.isEmpty {
                Spacer()
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(filteredStations, id: \.self) { station in
                            Button {
                                onSelectStation(station)
                                isRootPresented = false
                            } label: {
                                HStack {
                                    Text(station)
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
        .navigationBarHidden(true)
    }
}
