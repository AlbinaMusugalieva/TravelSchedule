//
//  CarrierDetailView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct CarrierDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let carrierName: String
    let carrierLogo: ImageResource
    
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(carrierLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 343, height: 104)
                    .padding(.top, 16)
                
                Text(carrierName)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
                
                Text("Детальная карточка перевозчика будет добавлена в следующем спринте.")
                    .font(.system(size: 15))
                    .foregroundColor(Color(.ypGreyUniversal))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                Spacer()
            }
        }
        .navigationTitle("О перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.ypBlack)
                }
            }
        }
    }
}
