//
//  StoriesFullscreenView.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//

import SwiftUI
import Combine

struct StoriesFullscreenView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var stories: [Stories]
    @State var currentIndex: Int
    
    private let storyDuration: Double = 10.0
    @State private var progress: Double = 0.0
    
    @State private var dragOffset: CGSize = .zero
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if currentIndex < stories.count {
                Image(stories[currentIndex].image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .ignoresSafeArea(edges: .bottom)
            }
            
            VStack(spacing: 0) {
                HStack(spacing: 6) {
                    ForEach(0..<stories.count, id: \.self) { index in
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.ypWhiteUniversal)
                                
                                Rectangle()
                                    .fill(Color.ypBlueUniversal)
                                    .frame(width: getProgressWidth(for: index, totalWidth: geometry.size.width))
                            }
                        }
                        .frame(height: 6)
                        .cornerRadius(3)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.ypBlackUniversal)
                                .frame(width: 30, height: 30)
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.ypWhiteUniversal)
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.top, 14)
                }
                .zIndex(2)
                
                Spacer()
                
                if currentIndex < stories.count {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(stories[currentIndex].title)
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(.ypWhiteUniversal)
                            .lineLimit(3)
                        
                        Text("Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(.ypWhiteUniversal)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
            }
            
            HStack(spacing: 0) {
                           Color.clear
                               .contentShape(Rectangle())
                               .onTapGesture {
                                   showPreviousStory()
                               }
                               .frame(width: UIScreen.main.bounds.width * 0.33)
                           
                           Color.clear
                               .contentShape(Rectangle())
                               .onTapGesture {
                                   showNextStory()
                               }
                       }
                       .frame(height: UIScreen.main.bounds.height * 0.8)
                       .frame(maxHeight: .infinity, alignment: .bottom)
                       .zIndex(1)
        }
        .offset(y: dragOffset.height > 0 ? dragOffset.height : 0)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.height > 0 {
                        dragOffset = gesture.translation
                    }
                }
                .onEnded { gesture in
                    if gesture.translation.height > 100 {
                        dismiss()
                    } else {
                        withAnimation(.spring()) {
                            dragOffset = .zero
                        }
                    }
                }
        )
        .onReceive(timer) { _ in
            updateProgress()
        }
    }
    
    private func getProgressWidth(for index: Int, totalWidth: CGFloat) -> CGFloat {
        if index < currentIndex {
            return totalWidth
        } else if index == currentIndex {
            return totalWidth * CGFloat(progress)
        } else {
            return 0
        }
    }
    
    private func updateProgress() {
        let step = 0.1 / storyDuration
        
        withAnimation(.linear(duration: 0.1)) {
            if progress < 1.0 {
                progress += step
            } else {
                showNextStory()
            }
        }
    }
    
    private func showNextStory() {
        if currentIndex < stories.count - 1 {
            progress = 0.0
            currentIndex += 1
            stories[currentIndex].isWatched = true
        } else {
            dismiss()
        }
    }
    
    private func showPreviousStory() {
        if currentIndex > 0 {
            progress = 0.0
            currentIndex -= 1
        } else {
            progress = 0.0
        }
    }
}
