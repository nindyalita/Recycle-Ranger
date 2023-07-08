//
//  ContentView.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 29/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var soundManager = SoundManager()
    
    var body: some View {
        PlayView()
            .environmentObject(soundManager)
            
    }
}
