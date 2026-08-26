//
//  StoriesFullscreenViewModel.swift
//  TravelSchedule
//
//  Created by Albina Musugalieva.
//
import SwiftUI
import Combine

@MainActor
final class StoriesFullscreenViewModel: ObservableObject, Sendable {
    @Published var progress: Double = 0.0
    
    private let storyDuration: Double = 10.0
    private var timerTask: Task<Void, Never>? = nil
    
    func startTimer(onNext: @escaping @Sendable () -> Void){
        timerTask?.cancel()
        progress = 0.0
        
        timerTask = Task {
            let totalSteps = 100
            let stepDuration = UInt64((storyDuration * 1_000_000_000) / Double(totalSteps))
            
            for step in 1...totalSteps {
                try? await Task.sleep(nanoseconds: stepDuration)
                if Task.isCancelled { return }
                
                withAnimation(.linear(duration: 0.1)) {
                    self.progress = Double(step) / Double(totalSteps)
                }
            }
            
            onNext()
        }
    }
    
    func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
    }
    
    func resetProgress() {
        progress = 0.0
    }
}
