//
//  GuideView.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 01/07/23.
//

import SwiftUI

struct GuideView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    let bins: [BinModel] = [BinModel.sharedExample, BinModel.sharedExample2, BinModel.sharedExample3, BinModel.sharedExample4]
    @State private var currentIndex: Int = 0
    
    var body: some View {
        
        ZStack (alignment: .topLeading){
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
                    
                    Button {
//                        withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
//                            currentIndex += 1
//                            if currentIndex >= bins.count {
//                                currentIndex = 0
//                            }
//                        }
                        
                        
                        
                    } label: {
                        Image("nextbutton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        
                    }
                    .padding(.top, 100)
                    .padding(.trailing, 20)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("showguide")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all))
            
            Button{
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("backbutton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
            }
            .padding(16)
            
            
        }
        
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    
}


struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
