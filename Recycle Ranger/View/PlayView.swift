//
//  PlayView.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 29/06/23.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var soundManager: SoundManager
    
    @State private var isZoomed = false
    @State private var blinking = false
    
    @State private var isTapped = false
    
    
    init(){
        //        printFonts()
    }
    
    func printFonts(){
        let fontFamilyNames = UIFont.familyNames
        
        for familyName in fontFamilyNames{
            print("---------------")
            print("Font family name -> [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names -> [\(names)]")
        }
    }
    
    var body: some View{
        NavigationStack{
            VStack{
                Text("Recycle")
                    .font(.custom("SFProRounded-Black", size: 70))
                    .position(x : 300, y : 50)
                    .foregroundColor(Color("purple"))
                
                
                Text("Ranger")
                    .font(.custom("SFProRounded-Black", size: 70))
                    .position(x: 400, y: -50)
                    .foregroundColor(Color("orange"))
                
                Text("Tap to Play!")
                    .font(.custom("SFProRounded-Bold", size: 20))
                    .foregroundColor(.white)
                    .scaleEffect(isZoomed ? 1.2 : 1.0)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true))
                    .onAppear {
//                        withAnimation {
                            isZoomed.toggle()
                            
                            soundManager.stopSoundEffect()
                            soundManager.stopBackgroundMusic()
                            soundManager.playBackgroundMusic(soundName: "intro", type: "mp3")
                            
//                        }
                    }
                
                NavigationLink(destination: MenuView(), isActive: $isTapped){
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            )
            .onTapGesture {
                isTapped = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

