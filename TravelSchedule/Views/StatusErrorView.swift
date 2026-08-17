//
//  StatusErrorView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI

struct StatusErrorView: View {
    let imageResource: ImageResource
    let message: String
    
    var body: some View {
        ZStack {
            Color(.ypWhite)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(imageResource)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 223, height: 223)
                
                Text(message)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
        }
    }
}
