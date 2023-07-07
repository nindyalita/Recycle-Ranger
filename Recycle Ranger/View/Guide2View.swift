//
//  Guide2View.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 01/07/23.
//

import SwiftUI

struct Guide2View: View {
    let binModel: BinModel
    
    var body: some View {
        VStack {
            Text(binModel.name)
                .font(.custom("SFProRounded-Bold", size: 36))
            
            Text(binModel.description)
                .font(.custom("SFProRounded-Medium", size: 15))
                .multilineTextAlignment(.center)
            
        }
    }
}

struct Guide2View_Previews: PreviewProvider {
    static var previews: some View {
        Guide2View(binModel: BinModel.sharedExample)
    }
}
