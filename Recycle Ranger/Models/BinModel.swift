//
//  Bin.swift
//  Recycle Ranger
//
//  Created by Nindya Alita Rosalia on 01/07/23.
//

import Foundation
import SwiftUI

enum BinStatus {
    case empty, filled
}


struct BinModel: Equatable, Identifiable{
    let id: String
    let name : String
    let imageName: String
    let description: String
    let position: CGPoint
    let status: BinStatus = .empty
    
    
    init(id: String, name: String, imageName: String, description: String, position: CGPoint = CGPoint(x: 0, y: 0)) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.description = description
        self.position = position
    }
    
    static let sharedExample = BinModel(
        id: UUID().uuidString,
        name: "Red Bin",
        imageName:  "redbin",
        description: "This bin is used to separate and recycle plastic.\nRecyclable plastics usually have a recycling symbol with a number on them. \nExamples include plastic bottles, food containers, and other plastic packaging"
    )
    
    static let sharedExample2 = BinModel(id: UUID().uuidString, name: "Blue Bin", imageName: "bluebin", description: "This bin is used to separate and recycle glass.\nIt includes glass bottles, jars, and other glass items")
    static let sharedExample3 = BinModel(id: UUID().uuidString, name: "Yellow Bin", imageName: "yellowbin", description: "This bin is used to separate and recycle paper.\nIt includes newspapers, letter paper, magazines, office paper, and cardboard")
    static let sharedExample4 = BinModel(id: UUID().uuidString, name: "Green Bin", imageName: "greenbin", description: "This bin is used to separate and recycle paper.\nIt includes newspapers, letter paper, magazines, office paper, and cardboard")
    
    
}

var collectBins = [
    BinModel(
        id: UUID().uuidString,
        name: "Red Bin",
        imageName: "collectred",
        description: "",
        position: CGPoint(x: UIScreen.main.bounds.minX + 32, y: UIScreen.main.bounds.midY + 120)
    ),
    
    BinModel(
        id: UUID().uuidString, name: "Blue Bin",
        imageName: "collectblue", description: "",
        position: CGPoint(x: UIScreen.main.bounds.midX - 150, y: UIScreen.main.bounds.midY + 110)
    ),
    
    BinModel(
        id: UUID().uuidString, name: "Blue Bin",
        imageName: "collectyellow", description: "",
        position: CGPoint(x: UIScreen.main.bounds.midX + 100, y: UIScreen.main.bounds.midY + 100)
    ),
    
    BinModel(
        id: UUID().uuidString, name: "Blue Bin",
        imageName: "collectgreen", description: "",
        position: CGPoint(x: UIScreen.main.bounds.maxX - 132, y: UIScreen.main.bounds.midY + 105)
    ),
]


var GuideBins = [
    BinModel(
        id: UUID().uuidString,
        name: "Red Bin",
        imageName: "redbin",
        description: "This bin is used to separate and recycle plastic.\nRecyclable plastics usually have a recycling symbol with a number on them. \nExamples include plastic bottles, food containers, and other plastic packaging",
        position: CGPoint(x: UIScreen.main.bounds.minX + 32, y: UIScreen.main.bounds.midY + 120)
    ),
    
    BinModel(
        id: UUID().uuidString,
        name: "Blue Bin",
        imageName: "bluebin",
        description: "This bin is used to separate and recycle glass.\nIt includes glass bottles, jars, and other glass items",
        position: CGPoint(x: UIScreen.main.bounds.midX - 150, y: UIScreen.main.bounds.midY + 110)
    ),
    
    BinModel(
        id: UUID().uuidString,
        name: "Red Bin",
        imageName: "yellowbin",
        description: "This bin is used to separate and recycle paper.\nIt includes newspapers, letter paper, magazines, office paper, and cardboard",
        position: CGPoint(x: UIScreen.main.bounds.midX + 100, y: UIScreen.main.bounds.midY + 100)
    ),
    
    BinModel(
        id: UUID().uuidString,
        name: "Yellow Bin",
        imageName: "greenbin",
        description: "This bin is used to separate and recycle paper.\nIt includes newspapers, letter paper, magazines, office paper, and cardboard",
        position: CGPoint(x: UIScreen.main.bounds.maxX - 132, y: UIScreen.main.bounds.midY + 105)
    ),

]
