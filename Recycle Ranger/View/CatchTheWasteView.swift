import SwiftUI

struct NewsPaper: Identifiable {
    let id = UUID()
    var position: CGPoint
    var speed: CGFloat
    var isOffScreen: Bool = false
    var hasScored: Bool = false
    var touchCount: Int = 0
    var opacity: Double = 1.0
}

struct Object: Identifiable {
    let id = UUID()
    var position: CGPoint
    var speed: CGFloat
    var isOffScreen: Bool = false
    var hasScored: Bool = false
    var imageName: String
    var touchCount: Int = 0
    var opacity: Double = 1.0
}




struct CatchTheWasteView: View {
    @EnvironmentObject var soundManager: SoundManager
    
    @State var binPosition = CGPoint(x: UIScreen.main.bounds.midX - 50, y: UIScreen.main.bounds.maxY - 100)
    
    @GestureState private var offset = CGSize.zero
    @State private var finalOffset = CGSize(width: 10, height: 100)
                      
    let images = [ "bottle", "bottleglass", "box", "glass", "keju",  "newspaper",  "orangefruit", "plastic" ]
    
    let binImages = ["collectred", "collectblue", "collectyellow", "collectgreen"]
    
    @State var binImage : String
    
    @State private var objects : [Object] = []
    @State private var score = 0
    @State private var numOfHeart = 8
    
    @State private var gameOver = false
    @State private var win = false
    
    @State private var draggOffset = CGSize.zero
    
    let maxNewsPapers = 2
    let maxBottles = 2
    
    let maxObjectOnScreen = 6
    
    init() {
        var tempObjects : [Object] = []
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let binIndex = Int.random(in: 0..<binImages.count)
        binImage =  binImages[binIndex]
        
        for _ in 0..<4 {
            let x = CGFloat.random(in: 100...(screenWidth - 100))
            let y : CGFloat = CGFloat.zero
            let randomIndex = Int.random(in: 0..<images.count)
            let imageName = images[randomIndex]
            let object = Object(position: CGPoint(x: x, y: y), speed: 3, imageName: imageName)
            tempObjects.append(object)
           
        }
        _objects = State(initialValue: tempObjects)
    }
    
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(binImage)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .position(x: binPosition.x + offset.width, y: binPosition.y)
                .gesture(
                    DragGesture()
                        .updating($offset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            binPosition.x += value.translation.width
                        }
                )
            VStack {
                Text("Score: \(score)")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                if gameOver {
                    Text("Game Over")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                }
                if win {
                    Text("You Win")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            ForEach(objects) { object in
                if !object.isOffScreen {
                    Image(object.imageName)
                        .frame(width: 10, height: 10)
                        .position(object.position)
                        .animation(.linear(duration: 1))
                        .opacity(object.opacity)
                        .onChange(of: object.position) { newPosition in
                            checkCollision(with: newPosition, object: object)
                        }
                }
            }
            
//            ForEach(Bottles) { bottle in
//                if !bottle.isOffScreen {
//                    Image("bottle")
//                        .frame(width: 10, height: 10)
//                        .position(bottle.position)
//                        .animation(.linear(duration: 1))
//                        .onChange(of: bottle.position) { newPosition in
//                            checkCollision(with: newPosition, object: bottle)
//                        }
//                }
//            }
            
        }
        .onReceive(timer) { _ in
            if !gameOver && !win {
                if objects.count < maxObjectOnScreen && Bool.random() {
                    let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
                    let randomIndex = Int.random(in: 0..<images.count)
                    let imageName = images[randomIndex]
                    objects.append(Object(position: CGPoint(x: x, y: 0), speed: CGFloat.random(in: 1...5), imageName: imageName))
                }
                
                
                for index in objects.indices {
                    if !objects[index].isOffScreen {
                        objects[index].position.y += objects[index].speed
                        
                        if objects[index].position.y > UIScreen.main.bounds.height {
                            objects[index].isOffScreen = true
                            
                            if !objects[index].hasScored {
                                objects[index].hasScored = true
                                objects[index].touchCount += 1
                                checkGameOver()
                            }
                        } else {
                            let distance = abs(finalOffset.height - objects[index].position.y)
                            if distance <= 1 && !objects[index].hasScored {
                                objects[index].hasScored = true
                                objects[index].touchCount += 1
                                checkGameOver()
                            }
                        }
                    }
                }
                objects.removeAll(where: { $0.isOffScreen })

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("plainbackground")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
    
    func checkCollision(with position: CGPoint, object: Object) {
        
        let bin = CGRect(x: binPosition.x + offset.width + 25, y: binPosition.y, width: 20, height: 20)
        
        
        if binImage == "collectyellow" {
            if let index = objects.firstIndex(where: { $0.position == position }) {
                let objectRect = CGRect(x: objects[index].position.x, y: objects[index].position.y, width: 100, height: 100)
                
                if objectRect.intersects(bin) {
                    withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                        objects[index].opacity = 0.0
                        objects[index].position.y += UIScreen.main.bounds.maxY
                    }
                    if object.imageName == "newspaper" || object.imageName == "box" || object.imageName == "book" {
                        score+=1
                        soundManager.playSoundEffect(soundName: "correct", type: "mp3")
                    } else {
                        numOfHeart -= 1
                        soundManager.playSoundEffect(soundName: "wrong", type: "mp3")
                    }
                    
                }
                
            }
            
        } else if binImage == "collectred" {
            if let index = objects.firstIndex(where: { $0.position == position }) {
                let objectRect = CGRect(x: objects[index].position.x, y: objects[index].position.y, width: 100, height: 100)
                
                if objectRect.intersects(bin) {
                    withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                        objects[index].opacity = 0.0
                        objects[index].position.y += UIScreen.main.bounds.maxY
                    }
                    if object.imageName == "bottle" || object.imageName == "plastic" || object.imageName == "plasticglass" {
                        score+=1
                        soundManager.playSoundEffect(soundName: "correct", type: "mp3")
                    } else {
                        numOfHeart -= 1
                        soundManager.playSoundEffect(soundName: "wrong", type: "mp3")
                    }
                    
                }
                
            }
            
        } else if binImage == "collectblue" {
            if let index = objects.firstIndex(where: { $0.position == position }) {
                let objectRect = CGRect(x: objects[index].position.x, y: objects[index].position.y, width: 100, height: 100)
                
                if objectRect.intersects(bin) {
                    withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                        objects[index].opacity = 0.0
                        objects[index].position.y += UIScreen.main.bounds.maxY
                    }
                    if object.imageName == "glass" || object.imageName == "bottleglass" {
                        score+=1
                        soundManager.playSoundEffect(soundName: "correct", type: "mp3")
                    } else {
                        numOfHeart -= 1
                        soundManager.playSoundEffect(soundName: "wrong", type: "mp3")
                    }
                    
                }
                
            }
        } else {
            if let index = objects.firstIndex(where: { $0.position == position }) {
                let objectRect = CGRect(x: objects[index].position.x, y: objects[index].position.y, width: 100, height: 100)
                
                if objectRect.intersects(bin) {
                    withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                        objects[index].opacity = 0.0
                        objects[index].position.y += UIScreen.main.bounds.maxY
                    }
                    if object.imageName == "keju" || object.imageName == "orangefruit"  {
                        score+=1
                        soundManager.playSoundEffect(soundName: "correct", type: "mp3")
                    } else {
                        numOfHeart -= 1
                        soundManager.playSoundEffect(soundName: "wrong", type: "mp3")
                    }
                    
                }
                
            }
        }
        
       
//        if object.imageName == "newspaper" {
//            if let index = objects.firstIndex(where: { $0.position == position }) {
//                let objectRect = CGRect(x: objects[index].position.x, y: objects[index].position.y, width: 100, height: 100)
//
//                if objectRect.intersects(bin) {
//                    withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
//                        objects[index].opacity = 0.0
//                        objects[index].position.y += UIScreen.main.bounds.maxY
//                    }
//
//                    score+=1
//                    soundManager.playSoundEffect(soundName: "correct", type: "mp3")
//                }
//
//            }
//        }
    }
    
    
    //    func checkCollision(with position: CGPoint, object: Any) {
    //        let objectHeight: CGFloat = 100 // Ubah sesuai dengan tinggi objek Anda
    //        let collisionThreshold: CGFloat = objectHeight * 0.75
    //
    //        if position.y >= finalOffset.height - collisionThreshold && position.y <= finalOffset.height + collisionThreshold {
    //            if object is NewsPaper {
    //                let newspaperIndex = NewsPapers.firstIndex(where: { $0.position == position })
    //                if let index = newspaperIndex {
    //                    if !NewsPapers[index].hasScored {
    //                        NewsPapers[index].hasScored = true
    //
    //                        let distance = abs(finalOffset.height - position.y)
    //                        let maxDistance = collisionThreshold
    //                        if distance <= maxDistance {
    //                            if NewsPapers[index].touchCount < 3 {
    //                                score += 1
    //                                checkGameOver()
    //                            }
    //                        }
    //                    }
    //                }
    //            } else if object is Bottle {
    //                let bottleIndex = Bottles.firstIndex(where: { $0.position == position })
    //                if let index = bottleIndex {
    //                    if !Bottles[index].hasScored {
    //                        Bottles[index].hasScored = true
    //
    //                        let distance = abs(finalOffset.height - position.y)
    //                        let maxDistance = collisionThreshold
    //                        if distance <= maxDistance {
    //                            score += 1
    //                            checkWin()
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    func checkGameOver() {
//        let newspaperCount = NewsPapers.filter { $0.touchCount >= 3 }.count
//        if newspaperCount >= 3 {
//            gameOver = true
//        }
    }
    
    func checkWin() {
//        let bottleCount = Bottles.filter { $0.hasScored }.count
//        if bottleCount >= 10 {
//            win = true
//        }
    }
}

struct CatchTheWasteView_Previews: PreviewProvider {
    static var previews: some View {
        CatchTheWasteView()
    }
}

