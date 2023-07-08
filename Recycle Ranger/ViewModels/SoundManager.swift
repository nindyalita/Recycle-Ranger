//
//  SoundManager.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 07/07/23.
//

import AVFoundation
import SwiftUI
class SoundManager: ObservableObject {
    
    @Published var backgroundMusicPlayer: AVAudioPlayer?
    @Published var soundEffectPlayer: AVAudioPlayer?

    func playBackgroundMusic(soundName: String, type: String) {
        guard let soundPath = Bundle.main.path(forResource: soundName, ofType: type) else { return }

        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
            backgroundMusicPlayer?.numberOfLoops = -1 // Mengulang secara terus-menerus
            backgroundMusicPlayer?.volume = 0.5 // Set volume menjadi 50%
            backgroundMusicPlayer?.prepareToPlay()
            backgroundMusicPlayer?.play()
        } catch {
            print("Couldn't play background music")
        }
    }

    func playSoundEffect(soundName: String, type: String) {
        guard let soundPath = Bundle.main.path(forResource: soundName, ofType: type) else { return }

        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
            soundEffectPlayer?.play()
        } catch {
            print("Couldn't play sound effect")
        }
    }

    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }

    func stopSoundEffect() {
        soundEffectPlayer?.stop()
    }
}
