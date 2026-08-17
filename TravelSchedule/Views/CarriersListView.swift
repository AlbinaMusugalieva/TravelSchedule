//
//  CarriersListView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct TrainTrip: Identifiable {
    let id = UUID()
    let carrierName: String
    let logoImage: ImageResource
    let transferText: String?
    let dateText: String
    let departureTime: String
    let durationText: String
    let arrivalTime: String
}

struct CarriersListView: View {
    @Binding var networkState: AppNetworkState
    @State private var isShowingFilters = false
    
    @State private var appliedFilters = FilterSettings()
    
    let departureCity: String
    let departureStation: String
    let arrivalCity: String
    let arrivalStation: String
    
    let trips = [
        TrainTrip(carrierName: "РЖД", logoImage: .brandIcon, transferText: "С пересадкой в Костроме", dateText: "14 января", departureTime: "22:30", durationText: "20 часов", arrivalTime: "08:15"),
        TrainTrip(carrierName: "ФГК", logoImage: .brandIcon2, transferText: nil, dateText: "15 января", departureTime: "01:15", durationText: "9 часов", arrivalTime: "09:00"),
        TrainTrip(carrierName: "Урал логистика", logoImage: .brandIcon3, transferText: nil, dateText: "16 января", departureTime: "12:30", durationText: "9 часов", arrivalTime: "21:00"),
        TrainTrip(carrierName: "РЖД", logoImage: .brandIcon, transferText: "С пересадкой в Костроме", dateText: "17 января", departureTime: "22:30", durationText: "20 часов", arrivalTime: "08:15")
    ]
    
    var filteredTrips: [TrainTrip] {
        trips.filter { trip in
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
                
                if filteredTrips.isEmpty {
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
                                NavigationLink(destination: CarrierDetailView(carrierName: trip.carrierName, carrierLogo: trip.logoImage)) {
                                    TripCardView(trip: trip)
                                }
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
        .fullScreenCover(isPresented: $isShowingFilters) {
            FiltersView(initialFilters: appliedFilters) { newFilters in
                appliedFilters = newFilters
                
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
}
