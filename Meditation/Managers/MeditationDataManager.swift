//
//  MeditationDataLoader.swift
//  Meditation
//
//  Created by Anastasiia Zolotova on 28.06.2023.
//

import Foundation
import AVFAudio

class MeditationDataManager {
    static func loadMeditationsFromJSON() -> [Meditation]? {
        if let fileURL = Bundle.main.url(forResource: "meditations-info", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let meditations = try decoder.decode([Meditation].self, from: jsonData)
                
                return MeditationDataManager.handleDuration(meditations: meditations)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
        return nil
    }
    
    static func handleDuration(meditations: [Meditation]) -> [Meditation] {
        
        var meditations_ = meditations
        
        for (index, meditation) in meditations_.enumerated().reversed() {
            do {
                let duration = try MeditationDataManager.getMP3Duration(filePath: meditation.track)
                
                if duration == 0 {
                    meditations_.remove(at: index)
                } else {
                    meditations_[index] = meditations_[index].setDuration(duration)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        
        return meditations_
    }
    
    static func getMP3Duration(filePath: String) throws -> TimeInterval {
        
        guard let fileURL = Bundle.main.url(forResource: filePath, withExtension: "mp3")
        else {
            print("Resource not found: \(filePath)")
            return 0
        }
        
        do {
            let file = try AVAudioFile(forReading: fileURL)
            let format = file.processingFormat
            
            return Double(file.length) / format.sampleRate
            
        } catch {
            print("Error reading the audio file: \(error.localizedDescription)")
        }
        
        return 0
    }
}
