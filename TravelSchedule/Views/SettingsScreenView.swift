//
//  SettingsScreenView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct SettingsScreenView: View {
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Настройки")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.ypBlack)
                
                Text("Этот экран будет добавлен в следующем спринте.")
                    .font(.system(size: 15))
                    .foregroundStyle(.ypGreyUniversal)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
    }
}

struct SettingsPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsScreenView().preferredColorScheme(.light)
            SettingsScreenView().preferredColorScheme(.dark)
        }
    }
}
