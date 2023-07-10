//
//  Menu2view.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 09/07/23.
//

import SwiftUI

struct Menu2view: View {
    var body: some View {
        HStack{
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("menubg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
    }
}

struct Menu2view_Previews: PreviewProvider {
    static var previews: some View {
        Menu2view()
    }
}
