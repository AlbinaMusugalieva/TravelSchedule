//
//  StoriesCell.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//
import SwiftUI

struct StoryCell: View {
    let stories: Stories
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(stories.image)
                .resizable()
                .scaledToFit()
            
            if stories.isWatched {
                Color.ypBlackUniversal
                    .opacity(0.4)
            }
            
            LinearGradient(
                colors: [.clear, .black.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
                       
            Text(stories.title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.ypWhiteUniversal)
                .lineLimit(3)
                .padding([.leading, .bottom], 8)
        }
        
        .frame(width: 92, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(stories.isWatched ? Color.clear : .ypBlueUniversal, lineWidth: 4)
                )
    }
}
