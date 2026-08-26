//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

@MainActor
struct StationSelectionView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var isRootPresented: Bool
    var onSelectStation: @Sendable (Station) -> Void
    
    @StateObject private var viewModel: StationSelectionViewModel
    
    init(city: City, isRootPresented: Binding<Bool>, onSelectStation: @escaping @Sendable (Station) -> Void) {
        self._isRootPresented = isRootPresented
        self.onSelectStation = onSelectStation
        self._viewModel = StateObject(wrappedValue: StationSelectionViewModel(city: city))
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
                TextField("Введите запрос", text: $viewModel.searchText)
                    .font(.system(size: 16))
                    .foregroundStyle(.ypBlack)
                if !viewModel.searchText.isEmpty {
                    Button { viewModel.searchText = "" } label: { Image(systemName: "xmark.circle.fill").foregroundStyle(.ypGreyUniversal) }
                }
            }
            .padding(.horizontal, 12).frame(height: 36)
            .background(colorScheme == .dark ? Color(.ypFillsTertiary) : Color(.ypLightGray))
            .cornerRadius(10).padding([.horizontal, .bottom], 16)
            
            if viewModel.filteredStations.isEmpty {
                Spacer()
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.filteredStations) { station in
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
