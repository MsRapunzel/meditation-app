//
//  MeditationViewCard.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 26.06.2023.
//

import SwiftUI

struct MeditationViewCard: View {
    var meditation: Meditation
    
    var body: some View {
        let height_: CGFloat = 376
        let width_: CGFloat = 360
        
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                // MARK: Image
                Image(meditation.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width_, height: height_, alignment: .center)
                    .clipped()

                // MARK: - Text
                VStack(alignment: .leading) {
                    Text(meditation.title)
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                .frame(width: width_, alignment: .leading)
                .background(.ultraThinMaterial)
            }
            .cornerRadius(20)
            .frame(width: width_, height: height_, alignment: .top)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray) .opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
        }
    }
}

struct MeditationViewCard_Previews: PreviewProvider {
    static var previews: some View {
        MeditationViewCard(meditation: Meditation.all[0])
    }
}
