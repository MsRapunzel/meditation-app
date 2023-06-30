//
//  MeditationViewModel.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 22.06.2023.
//

import Foundation

struct Meditation: Codable, Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    var duration: TimeInterval
    let track: String
    let image: String
}
