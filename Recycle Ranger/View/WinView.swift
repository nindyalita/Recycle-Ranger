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
                .font(.custom("SFProRounded-Medium", size: 24))
                .padding(.top, 20)
                .multilineTextAlignment(.center)
            
            
                NavigationLink(destination: PlayView()) {
                    Image("homebutton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 70)
                        .padding(.top, 200)
                        .padding(.trailing, 150)

                }
                
                NavigationLink(destination: CollectTheWasteView()) {
                    Image("restartbutton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 70)
                        .padding(.top, 200)
                        .padding(.leading, 150)

                }

            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("blurbg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()
    }
}
