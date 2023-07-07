import SwiftUI

struct NewsPaper: Identifiable {
    let id = UUID()
    var position: CGPoint
    var speed: CGFloat
    var isOffScreen: Bool = false
    var hasScored: Bool = false
    var touchCount: Int = 0
}

struct Bottle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var speed: CGFloat
    var isOffScreen: Bool = false
    var hasScored: Bool = false
}

struct CatchTheWasteView: View {
    @GestureState private var offset = CGSize.zero
    @State private var finalOffset = CGSize(width: 10, height: 100)
    
    @State private var NewsPapers: [NewsPaper] = []
    @State private var Bottles: [Bottle] = []
    
    @State private var score = 0
    @State private var gameOver = false
    @State private var win = false
    
    let maxNewsPapers = 2
    let maxBottles = 2
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image("plainredbin")
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .offset(x: finalOffset.width + offset.width, y: finalOffset.height + offset.height)
                .gesture(
                    DragGesture()
                        .updating($offset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            finalOffset.width += value.translation.width
                            finalOffset.height += value.translation.height
                        }
                )
            VStack {
                Text("Score: \(score)")
                    .font(.title)
                    .foregroundColor(.white)
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
            ForEach(NewsPapers) { newspaper in
                if !newspaper.isOffScreen {
                    Image("newspaper")
                        .frame(width: 10, height: 10)
                        .position(newspaper.position)
                        .animation(.linear(duration: 1))
                        .onChange(of: newspaper.position) { newPosition in
                            checkCollision(with: newPosition, object: newspaper)
                        }
                }
            }
            
            ForEach(Bottles) { bottle in
                if !bottle.isOffScreen {
                    Image("bottle")
                        .frame(width: 10, height: 10)
                        .position(bottle.position)
                        .animation(.linear(duration: 1))
                        .onChange(of: bottle.position) { newPosition in
                            checkCollision(with: newPosition, object: bottle)
                        }
                }
            }
            
        }
        .onReceive(timer) { _ in
            if !gameOver && !win {
                if NewsPapers.count < maxNewsPapers && Bool.random() {
                    let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
                    NewsPapers.append(NewsPaper(position: CGPoint(x: x, y: 0), speed: CGFloat.random(in: 1...5)))
                }
                
                if Bottles.count < maxBottles && Bool.random() {
                    let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
                    Bottles.append(Bottle(position: CGPoint(x: x, y: 0), speed: CGFloat.random(in: 1...5)))
                }
                
                for index in NewsPapers.indices {
                    if !NewsPapers[index].isOffScreen {
                        NewsPapers[index].position.y += NewsPapers[index].speed
                        
                        if NewsPapers[index].position.y > UIScreen.main.bounds.height {
                            NewsPapers[index].isOffScreen = true
                            
                            if !NewsPapers[index].hasScored {
                                NewsPapers[index].hasScored = true
                                NewsPapers[index].touchCount += 1
                                checkGameOver()
                            }
                        } else {
                            let distance = abs(finalOffset.height - NewsPapers[index].position.y)
                            if distance <= 1 && !NewsPapers[index].hasScored {
                                NewsPapers[index].hasScored = true
                                NewsPapers[index].touchCount += 1
                                checkGameOver()
                            }
                        }
                    }
                }
                
                for index in Bottles.indices {
                    if !Bottles[index].isOffScreen {
                        Bottles[index].position.y += Bottles[index].speed
                        
                        if Bottles[index].position.y > UIScreen.main.bounds.height {
                            Bottles[index].isOffScreen = true
                            
                            if !Bottles[index].hasScored {
                                Bottles[index].hasScored = true
                                score += 1
                                checkWin()
                            }
                        } else {
                            let distance = abs(finalOffset.height - Bottles[index].position.y)
                            if distance <= 1 && !Bottles[index].hasScored {
                                Bottles[index].hasScored = true
                                score += 1
                                checkWin()
                            }
                        }
                    }
                }
                
                NewsPapers.removeAll(where: { $0.isOffScreen })
                Bottles.removeAll(where: { $0.isOffScreen })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("plainbackground")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
    }
    
    func checkCollision(with position: CGPoint, object: Any) {
        let objectHeight: CGFloat = 5 // Ubah sesuai dengan tinggi objek Anda
        let collisionThreshold: CGFloat = objectHeight * 0.75
        
        if position.y >= finalOffset.height - collisionThreshold && position.y <= finalOffset.height + collisionThreshold {
            if object is NewsPaper {
                let newspaperIndex = NewsPapers.firstIndex(where: { $0.position == position })
                if let index = newspaperIndex {
                    if !NewsPapers[index].hasScored {
                        NewsPapers[index].hasScored = true
                        
                        let distance = abs(finalOffset.height - position.y)
                        let maxDistance = collisionThreshold
                        if distance <= maxDistance {
                            if NewsPapers[index].touchCount < 3 {
                                score += 1
                                checkGameOver()
                            }
                        }
                    }
                }
            } else if object is Bottle {
                let bottleIndex = Bottles.firstIndex(where: { $0.position == position })
                if let index = bottleIndex {
                    if !Bottles[index].hasScored {
                        Bottles[index].hasScored = true
                        
                        let distance = abs(finalOffset.height - position.y)
                        let maxDistance = collisionThreshold
                        if distance <= maxDistance {
                            score += 1
                            checkWin()
                        }
                    }
                }
            }
        }
    }
    
    func checkGameOver() {
        let newspaperCount = NewsPapers.filter { $0.touchCount >= 3 }.count
        if newspaperCount >= 3 {
            gameOver = true
        }
    }
    
    func checkWin() {
        let bottleCount = Bottles.filter { $0.hasScored }.count
        if bottleCount >= 10 {
            win = true
        }
    }
}

struct CatchTheWasteView_Previews: PreviewProvider {
    static var previews: some View {
        CatchTheWasteView()
    }
}

