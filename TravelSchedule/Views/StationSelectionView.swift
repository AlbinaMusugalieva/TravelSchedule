//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct StationSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    let city: City
    @Binding var isRootPresented: Bool
    var onSelectStation: (Station) -> Void
    
    @State private var searchText: String = ""
    @Environment(\.colorScheme) private var colorScheme
    
    var filteredStations: [Station] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else {
            return city.stations
        }
        return city.stations.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.ypBlack)
                }
                Spacer()
                Text("Выбор вокзала")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.ypBlack)
                Spacer()
                Image(systemName: "chevron.left").font(.system(size: 20)).opacity(0)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass").foregroundStyle(.ypGreyUniversal)
                TextField("Введите запрос", text: $searchText)
                    .font(.system(size: 16))
                    .foregroundStyle(.ypBlack)
                if !searchText.isEmpty {
                    Button { searchText = "" } label: { Image(systemName: "xmark.circle.fill").foregroundStyle(.ypGreyUniversal) }
                }
            }
            .padding(.horizontal, 12).frame(height: 36)
            .background(colorScheme == .dark ? Color(.ypFillsTertiary) : Color(.ypLightGray))
            .cornerRadius(10).padding([.horizontal, .bottom], 16)
            
            if filteredStations.isEmpty {
                Spacer()
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredStations) { station in
                            Button {
                                onSelectStation(station)
                                isRootPresented = false
                            } label: {
                                HStack {
                                    Text(station.name)
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundStyle(.ypBlack)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(.ypBlack)
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 54)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            
                            Divider().padding(.horizontal, 16)
                        }
                    }
                }
            }
        }
        .background(.ypWhite)
        .navigationBarHidden(true)
    }
}
