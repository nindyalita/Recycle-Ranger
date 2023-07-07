//
//  GuideView.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 01/07/23.
//

import SwiftUI

struct GuideView: View {
    let bins: [BinModel] = [BinModel.sharedExample, BinModel.sharedExample2, BinModel.sharedExample3, BinModel.sharedExample4]
    @State private var currentIndex: Int = 0
    
    var body: some View {

            NavigationView{
                VStack {
                    Text(bins[currentIndex].name)
                        .font(.custom("SFProRounded-Bold", size: 36))
                        .padding(.top, 30.0)
                    Text(bins[currentIndex].description)
                        .font(.custom("SFProRounded-Medium", size: 15))
                        .multilineTextAlignment(.center)
                    HStack{
                        
                        Spacer()
                        
                        Image(bins[currentIndex].imageName)
                            .frame(width: 200, height: 200)
                            .padding(.leading, 130.0)
                        
                        Spacer()
                        
                        Button(action: {
                            currentIndex += 1
                            if currentIndex >= bins.count {
                                currentIndex = 0
                            }
                        }) {
                            Image("nextbutton") 
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 75)
                            
                        }
                        .padding(.top, 100)
                        .padding(.trailing, 20)
                    }

                }
//                .overlay(
//                    NavigationLink(destination: MenuView()) {
//                                Image("homebutton")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 140, height: 70)
//                                    .padding(.bottom, 210.0)
//                                    .padding(.trailing, 700.0)
//                            }
//                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("showguide")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all))
            }


    }
}


struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
