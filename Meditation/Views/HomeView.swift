//
//  HomeView.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 28.06.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                    .frame(height: 30)
                
                MeditationsList(meditations: Meditation.all)
            }
            .navigationTitle("Meditations")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
