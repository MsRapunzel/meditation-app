//
//  PlayerView.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 22.06.2023.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: PlayerManager
    var meditation: Meditation
    var isPreview: Bool = false
    @State private var bindingValue: Double = 0.0
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    
    var body: some View {
        
        ZStack {
            // MARK: - Background
            // MARK: Image
            Image(meditation.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            // MARK: Blur View
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            // MARK: - Buttons
            VStack(spacing: 32) {
                // MARK: Dismiss Button
                HStack{
                    Button {
                        audioManager.stop()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                
                
                // MARK: Title
                
                Text(meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                // MARK: Playback
                
                if let player = audioManager.player {
                    
                    VStack(spacing: 5) {
                        // MARK: Playback Timeline
                        
                        Slider(value: $bindingValue, in: 0...player.duration) { editing in
                            print("editing", editing)
                            
                            isEditing = editing
                            
                            if !editing {
                                player.currentTime = bindingValue
                            }
                        }
                        .accentColor(.white)
                        
                        // MARK: Playback Time
                        HStack {
                            Text(DateComponentsFormatter.positional.string(
                                from: isEditing ? bindingValue : player.currentTime) ?? "0:00")
                            
                            Spacer()
                            
                            Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                    }
                    
                    
                    // MARK: Playback Controls
                    HStack() {
                        // MARK: Repeat Button
                        PlaybackControlButton(
                            systemName: audioManager.isLooping ? "repeat.1" : "repeat") {
                                audioManager.toggleLoop()
                            }
                        
                        Spacer()
                        
                        
                        // MARK: Backward Button
                        PlaybackControlButton(systemName: "gobackward.10") {
                            player.currentTime -= 10
                        }
                        
                        Spacer()
                        
                        // MARK: Play / Pause Button
                        PlaybackControlButton(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                            audioManager.playPause()
                        }
                        
                        Spacer()
                        
                        // MARK: Forward Button
                        PlaybackControlButton(systemName: "goforward.10") {
                            player.currentTime += 10
                        }
                        
                        Spacer()
                        
                        // MARK: Stop Button
                        PlaybackControlButton(systemName: "stop.fill") {
                            audioManager.stop()
                            dismiss()
                        }
                    }
                }
            }
            .padding(20)
        }
        
        .onAppear{
            audioManager.startPlayer(track: meditation.track, isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            guard let player = audioManager.player, !isEditing else { return}
            bindingValue = player.currentTime
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
  
    static var previews: some View {
        PlayerView(meditation: Meditation.all[0], isPreview: true)
            .environmentObject(PlayerManager())
    }
}
