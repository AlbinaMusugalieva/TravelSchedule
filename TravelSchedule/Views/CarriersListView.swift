//
//  CarriersListView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

@MainActor
struct CarriersListView: View {
    @Binding var networkState: AppNetworkState
    
    let departureCity: String
    let departureStation: String
    let arrivalCity: String
    let arrivalStation: String
    
    @State private var isShowingFilters = false
    @State private var appliedFilters = FilterSettings()
    
    @StateObject private var viewModel: CarriersListViewModel
    
    init(
        networkState: Binding<AppNetworkState>,
        departureCity: String,
        departureStation: String,
        departureCode: String,
        arrivalCity: String,
        arrivalStation: String,
        arrivalCode: String
    ) {
        self._networkState = networkState
        self.departureCity = departureCity
        self.departureStation = departureStation
        self.arrivalCity = arrivalCity
        self.arrivalStation = arrivalStation
        
        self._viewModel = StateObject(wrappedValue: CarriersListViewModel(
            fromCode: departureCode,
            toCode: arrivalCode
        ))
    }
    
    var filteredTrips: [TrainTrip] {
        viewModel.trips.filter { trip in
            if let showWithTransfers = appliedFilters.showWithTransfers {
                let hasTransfer = trip.transferText != nil
                if showWithTransfers && !hasTransfer { return false }
                if !showWithTransfers && hasTransfer { return false }
            }
            
            let hour = Int(trip.departureTime.prefix(2)) ?? 0
            
            let isAnyTimeFilterActive = appliedFilters.isMorning || appliedFilters.isAfternoon || appliedFilters.isEvening || appliedFilters.isNight
            
            if isAnyTimeFilterActive {
                var matchesMorning = false
                var matchesAfternoon = false
                var matchesEvening = false
                var matchesNight = false
                
                if appliedFilters.isMorning && (hour >= 6 && hour < 12) { matchesMorning = true }
                if appliedFilters.isAfternoon && (hour >= 12 && hour < 18) { matchesAfternoon = true }
                if appliedFilters.isEvening && (hour >= 18 && hour < 24) { matchesEvening = true }
                if appliedFilters.isNight && (hour >= 0 && hour < 6) { matchesNight = true }
                
                if !(matchesMorning || matchesAfternoon || matchesEvening || matchesNight) {
                    return false
                }
            }
            return true
        }
    }
    
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("\(departureCity) (\(departureStation)) → \(arrivalCity) (\(arrivalStation))")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top], 16)
                    .padding(.bottom, 12)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Загрузка рейсов...")
                        .tint(.ypBlueUniversal)
                    Spacer()
                } else if filteredTrips.isEmpty {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.ypBlack)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(filteredTrips) { trip in
                                NavigationLink(destination: CarrierDetailView(
                                    carrierCode: trip.carrierCode,
                                    carrierName: trip.carrierName,
                                    carrierLogo: trip.logoImage
                                )) {
                                    TripCardView(trip: trip)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                
                Button(action: {
                    isShowingFilters = true
                }) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.ypWhiteUniversal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(.ypBlueUniversal)
                        .cornerRadius(16)
                }
                .padding([.horizontal, .bottom], 16)
                .padding(.top, 8)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.fetchRealSchedule()
        }
        .fullScreenCover(isPresented: $isShowingFilters) {
            FiltersView(initialFilters: appliedFilters) { @Sendable newFilters in
                Task {
                    await MainActor.run {
                        appliedFilters = newFilters
                    }
                }
            }
        }
    }
}
struct TripCardView: View {
    let trip: TrainTrip
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.ypWhite))
                        .frame(width: 36, height: 36)
                    
                    Image(trip.logoImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(trip.carrierName)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.ypBlackUniversal)
                    
                    if let transfer = trip.transferText {
                        Text(transfer)
                            .font(.system(size: 12))
                            .foregroundStyle(.ypRedUniversal)
                    }
                }
                
                Spacer()
                
                Text(trip.dateText)
                    .font(.system(size: 12))
                    .foregroundStyle(.ypBlackUniversal)
                    .padding(.top, 2)
            }
            
            HStack(spacing: 4) {
                Text(trip.departureTime)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.ypBlackUniversal)
                
                ZStack {
                    Divider()
                        .overlay(Color(.ypGreyUniversal))
                    
                    Text(trip.durationText)
                        .font(.system(size: 12))
                        .foregroundStyle(.ypBlackUniversal)
                        .padding(.horizontal, 8)
                        .background(.ypLightGray)
                }
                .padding(.horizontal, 4)
                
                Text(trip.arrivalTime)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.ypBlackUniversal)
            }
        }
        .padding(14)
        .background(Color(.ypLightGray))
        .cornerRadius(20)
    }
}
