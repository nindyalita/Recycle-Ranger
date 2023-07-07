//
//  PlayView.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 29/06/23.
//

import SwiftUI

struct PlayView: View {
    @State private var isZoomed = false
    
    init(){
        printFonts()
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
        NavigationView{
            VStack{
                Text("Recycle")
                    .font(.custom("SFProRounded-Black", size: 70))
                    .position(x : 300, y : 50)
                    .foregroundColor(Color("purple"))
                Text("Ranger")
                    .font(.custom("SFProRounded-Black", size: 70))
                    .position(x: 400, y: -50)
                    .foregroundColor(Color("orange"))
                
                NavigationLink(destination: MenuView()){
                    Text("Tap to Play!")
                        .font(.custom("SFProRounded-Bold", size: 20))
                        .foregroundColor(.white)
                        .scaleEffect(isZoomed ? 1.2 : 1.0)
                        .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true))
                        .onAppear {
                            withAnimation {
                                isZoomed.toggle()
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

