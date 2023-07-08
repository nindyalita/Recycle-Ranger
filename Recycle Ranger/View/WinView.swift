//
//  WinView.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 02/07/23.
//

import SwiftUI

struct WinView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 760, height: 330)
                .cornerRadius(20)
                .opacity(0.8)
                .padding(.top, 30)
            
            Text("Congratulations!")
                .font(.custom("SFProRounded-Black", size: 64))
                .foregroundColor(Color("yellow"))
                .padding(.bottom, 90)
            
            Text("You have successfully sorted the trash correctly.")
                .font(.custom("SFProRounded-Medium", size: 20))
                .padding(.top, 2)
                .multilineTextAlignment(.center)
            
            HStack(alignment: .center){
                NavigationLink(destination: PlayView()) {
                    VStack(spacing: 2){
                        Image("backbutton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 70)
                        
                        Text("Exit").font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("purple2"))
                    }
                    .padding(.top, 200)
                }
                .padding(.trailing, 52)
                NavigationLink(destination: CollectTheWasteView()) {
                    VStack(spacing: 2){
                        Image("restartbutton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 70)
                        
                        Text("Restart").font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("blue2"))
                    }
                    .padding(.top, 200)
                    

                }
            }
            .frame(maxWidth: .infinity)
            
            
                
                
                

            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("blurbg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()
    }
}
