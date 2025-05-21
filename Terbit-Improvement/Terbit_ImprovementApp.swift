//
//  Terbit_ImprovementApp.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 13/05/25.
//

import SwiftUI
import SwiftData

@main
struct Terbit_ImprovementApp: App {
    
    @StateObject private var streakManager = StreakManager()

    var body: some Scene {
        
        WindowGroup {
            MainView()
                .environmentObject(streakManager)
        }
    }
}
