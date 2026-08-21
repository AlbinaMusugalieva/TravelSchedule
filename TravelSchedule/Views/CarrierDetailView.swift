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
    let carrierEmail: String
    let carrierPhone: String
    
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Image(carrierLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 104)
                    .frame(maxWidth: .infinity)
                    .padding([.top,.bottom], 16)
                
                Text(carrierName)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlack)
                    
                    Text(carrierEmail)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.ypBlueUniversal)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlack)
                    
                    Text(carrierPhone)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.ypBlueUniversal)
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.ypBlack)
                }
            }
        }
    }
}
