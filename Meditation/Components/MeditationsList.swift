//
//  MeditationsList.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 28.06.2023.
//

import SwiftUI

struct MeditationsList: View {
    var meditations: [Meditation]
    
    var body: some View {
        LazyVStack(spacing: 32) {
            ForEach(meditations) { meditation in
                NavigationLink(destination: MeditationView(meditation: meditation)) {
                    MeditationViewCard(meditation: meditation)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MeditationsList_Previews: PreviewProvider {
    static var previews: some View {
        MeditationsList(meditations: Meditation.all)
    }
}
