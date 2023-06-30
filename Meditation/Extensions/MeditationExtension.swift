//
//  MeditationExtension.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 30.06.2023.
//

import Foundation

extension Meditation {
    static var all: [Meditation] {
        if let meditations = MeditationDataManager.loadMeditationsFromJSON() {
            return meditations
        } else {
            return []
        }
    }
    
    func setDuration(_ newDuration: TimeInterval) -> Meditation {
        return Meditation(title: self.title,
                          description: self.description,
                          duration: newDuration,
                          track: self.track,
                          image: self.image)
    }
}
