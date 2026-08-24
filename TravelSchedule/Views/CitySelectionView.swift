//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct CitySelectionView: View {
    @Binding var isPresented: Bool
    var onSelectStation: (Station) -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var viewModel = CitySelectionViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.ypBlack)
                    }
                    Spacer()
                    Text("Выбор города")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.ypBlack)
                    Spacer()
                    Image(systemName: "chevron.left").font(.system(size: 20)).opacity(0)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                // Строка текстового поиска
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
                
                switch viewModel.screenState {
                case .loading:
                    Spacer()
                    ProgressView()
                        .tint(.blue)
                    Spacer()
                    
                case .error:
                    Spacer()
                    Text("Ошибка загрузки данных")
                        .foregroundColor(.red)
                    Spacer()
                    
                case .content:
                    if viewModel.filteredCities.isEmpty {
                        Spacer()
                        Text("Город не найден")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.ypBlack)
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.filteredCities) { city in
                                    NavigationLink(destination: StationSelectionView(
                                        city: city,
                                        isRootPresented: $isPresented,
                                        onSelectStation: onSelectStation
                                    )) {
                                        HStack {
                                            Text(city.name)
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
            }
            .background(.ypWhite)
            .task {
                await viewModel.loadCities()
            }
        }
    }
}
