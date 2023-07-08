//
//  TimerView.swift
//  Recycle Ranger
//
//  Created by NIndya Alita Rosalia on 06/07/23.
//

import SwiftUI

struct TimerView: View {
    @State private var timerCount = 90
    @State private var isTimerRunning = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(timerCount)")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                isTimerRunning.toggle()
                
                if isTimerRunning {
                    timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                } else {
                    timer.upstream.connect().cancel()
                }
            }) {
                Text(isTimerRunning ? "Stop Timer" : "Start Timer")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .onReceive(timer) { _ in
            if isTimerRunning {
                if timerCount > 0 {
                    timerCount -= 1
                } else {
                    // Timer has reached zero, perform any desired actions here
                    isTimerRunning = false // Stop the timer
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
