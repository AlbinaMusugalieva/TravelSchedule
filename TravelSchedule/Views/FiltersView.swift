//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct FilterSettings {
    var isMorning: Bool = false
    var isAfternoon: Bool = false
    var isEvening: Bool = false
    var isNight: Bool = false
    var showWithTransfers: Bool?
}

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    
    let initialFilters: FilterSettings
    var onApply: (FilterSettings) -> Void
    
    @State private var isMorning: Bool = false
    @State private var isAfternoon: Bool = false
    @State private var isEvening: Bool = false
    @State private var isNight: Bool = false
    @State private var showWithTransfers: Bool? = nil
    
    var isAnyFilterSelected: Bool {
        isMorning || isAfternoon || isEvening || isNight || (showWithTransfers != nil)
    }
    
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.ypBlack)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Время отправления")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.ypBlack)
                            
                            VStack(spacing: 0) {
                                FilterCheckboxRow(title: "Утро 06:00 - 12:00", isChecked: $isMorning)
                                FilterCheckboxRow(title: "День 12:00 - 18:00", isChecked: $isAfternoon)
                                FilterCheckboxRow(title: "Вечер 18:00 - 00:00", isChecked: $isEvening)
                                FilterCheckboxRow(title: "Ночь 00:00 - 06:00", isChecked: $isNight)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Показывать варианты с\nпересадками")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.ypBlack)
                                .lineSpacing(4)
                            
                            VStack(spacing: 0) {
                                FilterRadioButtonRow(title: "Да", isSelected: showWithTransfers == true) {
                                    showWithTransfers = true
                                }
                                
                                FilterRadioButtonRow(title: "Нет", isSelected: showWithTransfers == false) {
                                    showWithTransfers = false
                                }
                            }
                        }
                    }
                    .padding([.horizontal, .top], 16)
                    
                    Spacer().frame(height: 90)
                }
            }
            
            if isAnyFilterSelected {
                VStack {
                    Spacer()
                    Button(action: {
                        let updatedFilters = FilterSettings(
                            isMorning: isMorning,
                            isAfternoon: isAfternoon,
                            isEvening: isEvening,
                            isNight: isNight,
                            showWithTransfers: showWithTransfers
                        )
                        onApply(updatedFilters)
                        dismiss()
                    }) {
                        Text("Применить")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.ypWhite)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(.ypBlueUniversal)
                            .cornerRadius(16)
                    }
                    .padding([.horizontal, .bottom], 16)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            isMorning = initialFilters.isMorning
            isAfternoon = initialFilters.isAfternoon
            isEvening = initialFilters.isEvening
            isNight = initialFilters.isNight
            showWithTransfers = initialFilters.showWithTransfers
        }
    }
}

struct FilterCheckboxRow: View {
    let title: String
    @Binding var isChecked: Bool
    
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundStyle(.ypBlack)
                
                Spacer()
                
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .font(.system(size: 22))
                    .foregroundStyle(.ypBlack)
            }
            .frame(height: 48)
            .contentShape(Rectangle())
        }
    }
}

struct FilterRadioButtonRow: View {
    let title: String
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button {
            onSelect()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundStyle(.ypBlack)
                
                Spacer()
                
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .font(.system(size: 22))
                    .foregroundStyle(.ypBlack)
            }
            .frame(height: 48)
            .contentShape(Rectangle())
        }
    }
}
