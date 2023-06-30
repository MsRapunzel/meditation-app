//
//  MeditationView.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 22.06.2023.
//

import SwiftUI

struct MeditationView: View {
    var meditation: Meditation
    @State private var showPlayer = false
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top
            ZStack {
                //MARK: Image
                Image(meditation.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height / 3)
                
                // MARK: Blur View
                Rectangle()
                    .background(.thinMaterial)
                    .opacity(0.25)
                    .ignoresSafeArea()
            }
            
            // MARK: - Descrtiption
            ZStack {
                // MARK: Background
                Color(red: 24/255, green: 23/255, blue: 22/255)
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Type & Duration
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(DateComponentsFormatter.abbreviated.string(from: meditation.duration) ?? meditation.duration.formatted() + "S")
                            .font(.title2)
                    }
//                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)
                    
                    // MARK: Title
                    Text(meditation.title)
                        .font(.largeTitle)
                    
                    // MARK: Play Button
                    Button {
                        showPlayer = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                    }
                    
                    // MARK: Description
                    Text(meditation.description)
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(20)
            }
            .frame(height: UIScreen.main.bounds.height * 2 / 3)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(meditation: meditation)
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
 
    
    static var previews: some View {
        MeditationView(meditation: Meditation.all[1])
            .environmentObject(PlayerManager())
    }
}
