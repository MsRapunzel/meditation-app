//
//  MeditationApp.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 21.06.2023.
//

import SwiftUI

@main
struct MeditationApp: App {
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
