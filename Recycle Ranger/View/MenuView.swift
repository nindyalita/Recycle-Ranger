//
//  MenuView.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 29/06/23.
//

import SwiftUI

struct MenuView: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 760, height: 330)
                    .cornerRadius(20)
                    .opacity(0.8)
                
                VStack{
                    HStack{
                        VStack{
                            ZStack{
                                Circle()
                                    .foregroundColor(Color("purple"))
                                    .frame(width: 120, height: 120)
                                NavigationLink(destination: GuideView()) {
                                    Image("book")
                                }
                                
                            }
                            
                            Text("Guide")
                                .font(.custom("SFProRounded-Bold", size: 20))
                                .foregroundColor(Color("orange"))
                            
                        }
                        .padding(.trailing, 180.0)
                        
                        VStack{
                            ZStack{
                                Circle()
                                    .foregroundColor(Color("orange"))
                                    .frame(width: 120, height: 120)
                                NavigationLink(destination: CatchTheWasteView()) {
                                    Image("catch")
                                }
                                
                            }
                            
                            Text("Catch The Waste")
                                .font(.custom("SFProRounded-Bold", size: 20))
                                .foregroundColor(Color("purple"))
                        }
                    }
                    
                    
                    // menu dua bawah
                    HStack{
                        VStack{
                            ZStack{
                                Circle()
                                    .foregroundColor(Color("orange"))
                                    .frame(width: 120, height: 120)
                                NavigationLink(destination: CollectTheWasteView()) {
                                    Image("collect")
                                }
                            }
                            
                            Text("Collect The Waste")
                                .font(.custom("SFProRounded-Bold", size: 20))
                                .foregroundColor(Color("purple"))
                            
                        }
                        .padding(.trailing, 150.0)
                        
                        VStack{
                            ZStack{
                                Circle()
                                    .foregroundColor(Color("purple"))
                                    .frame(width: 120, height: 120)
                                NavigationLink(destination: CaptureTheWasteView()) {
                                    Image("capture")
                                }
                                
                            }
                            
                            Text("Capture The Waste")
                                .font(.custom("SFProRounded-Bold", size: 20))
                                .foregroundColor(Color("orange"))
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            )
            
            
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

