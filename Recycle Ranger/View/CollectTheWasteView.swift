import SwiftUI

struct CollectTheWasteView: View {
    @EnvironmentObject var soundManager: SoundManager
    
    let images = ["book", "bottle", "bottleglass", "box", "glass", "keju",  "newspaper",  "orangefruit", "plastic",  "plasticglass"]
    
    let numberOfImages = 10
    @State var numberOfSolvedImages = 0

    @State private var objectPositions: [(position: CGPoint, imageName: String, opacity: Double)]
    @State private var activeIndex: Int?
    @State private var isGameWon = false
    @State private var isGameLost = false
    
    
    //timer state
    @State private var timerCount = 30
    @State private var isTimerRunning = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        var positions: [(CGPoint, String, Double)] = []
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        for _ in 0..<numberOfImages {
            let x = CGFloat.random(in: 100...(screenWidth - 100))
            let y = CGFloat.random(in: 160...(screenHeight - 50))
            let randomIndex = Int.random(in: 0..<images.count)
            let imageName = images[randomIndex]
            positions.append((CGPoint(x: x, y: y), imageName, 1.0))
        }
        _objectPositions = State(initialValue: positions)
    }
    
    var body: some View {
        
        ZStack {
            ForEach(collectBins, id: \.id){ bin in
                Image(bin.imageName)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .position(x: bin.position.x, y: bin.position.y)
            }
            
            
            ForEach(0..<numberOfImages, id: \.self) { index in
                if objectPositions[index].imageName != "" {
                    randomImage(index: index)
                        .frame(width: 100, height: 100)
                        .position(objectPositions[index].position)
                        .opacity(objectPositions[index].opacity)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    activeIndex = index
                                    objectPositions[index].position = value.location
                                }
                                .onEnded { _ in
                                    activeIndex = nil
                                    checkCollision(index: index)
                                    checkWinCondition()
                                }
                        )
                }
            }
            
            
            
            
//            ForEach(collectBins, id: \.id){ bin in
//                Rectangle().fill(.black.opacity(0.3))
//                    .frame(width: 100, height: 110)
//                    .position(x: bin.position.x, y: bin.position.y)
//            }
            
            // Menggunakan NavigationLink untuk navigasi ke halaman WinView
            NavigationLink(destination: WinView(), isActive: $isGameWon) {
                EmptyView()
            }
            
            NavigationLink(destination: GameOverView(), isActive: $isGameLost) {
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("plainbackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
        .overlay(alignment: .top) {
            ZStack{
                Circle()
                    .stroke(Color("lightYellow"), lineWidth: 6)
                    .frame(width: 136, height: 136)
                
                Circle()
                    .fill(Color("blueColor"))
                    .frame(width: 100, height: 100)
                    .overlay {
                        Text("\(timerCount)").font(.largeTitle.bold())
                    }
            }
            .padding(20)
        }
        .onAppear{
            soundManager.stopBackgroundMusic()
            soundManager.playBackgroundMusic(soundName: "playBGM", type: "mp3")
            isTimerRunning.toggle()
            if isTimerRunning {
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            } else {
                timer.upstream.connect().cancel()
            }
        }
        .onReceive(timer) { _ in
            if isTimerRunning {
                if timerCount > 0 {
                    timerCount -= 1
                } else {
                    // Timer has reached zero, perform any desired actions here
                    
                    //cek if the timer has reached zero and not won
                    if(numberOfSolvedImages < numberOfImages){
                        isGameLost = true
                        
                        soundManager.stopBackgroundMusic()
                        soundManager.playSoundEffect(soundName: "gameover", type: "mp3")
                    }
                    
                    isTimerRunning = false // Stop the timer
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func randomImage(index: Int) -> some View {
        let imageName = objectPositions[index].imageName
        
        if activeIndex == index {
            return AnyView(Image(imageName)
                .frame(width: 200, height: 200))
        } else {
            return AnyView(Image(imageName))
        }
    }
    
    func checkCollision(index: Int) {
        
        let redBin = CGRect(x: collectBins[0].position.x, y: collectBins[2].position.y, width: 100, height: 110)
        let blueBin = CGRect(x: collectBins[1].position.x, y: collectBins[2].position.y, width: 100, height: 110)
        let yellowBin = CGRect(x: collectBins[2].position.x, y: collectBins[2].position.y, width: 100, height: 110)
        let greenBin = CGRect(x: collectBins[3].position.x, y: collectBins[2].position.y, width: 100, height: 110)
        
        //redBin
        if objectPositions[index].imageName == "bottle" || objectPositions[index].imageName == "plastic" || objectPositions[index].imageName == "plasticglass" {
            let objectRect = CGRect(x: objectPositions[index].position.x, y: objectPositions[index].position.y, width: 100, height: 100)
            
            if objectRect.intersects(redBin) {
                withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                    objectPositions[index].opacity = 0.0
                }
                
                numberOfSolvedImages += 1
                
                soundManager.playSoundEffect(soundName: "correct", type: "mp3")
            } else {
                objectPositions[index].position = initialPositionFor(index: index)
                soundManager.playSoundEffect(soundName: "wrong", type: "mp3")
            }
            
        }
        
        //blue bin
        if objectPositions[index].imageName == "glass" || objectPositions[index].imageName == "bottleglass" {
            let objectRect = CGRect(x: objectPositions[index].position.x, y: objectPositions[index].position.y, width: 100, height: 100)
            
            if objectRect.intersects(blueBin) {
                withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                    objectPositions[index].opacity = 0.0
                }
                numberOfSolvedImages += 1
                
                soundManager.playSoundEffect(soundName: "correct", type: "mp3")
            } else {
                objectPositions[index].position = initialPositionFor(index: index)
                soundManager.playSoundEffect(soundName: "wrong", type: "mp3")
            }
        }
        
        //yellow bin
        if objectPositions[index].imageName == "newspaper" || objectPositions[index].imageName == "box" || objectPositions[index].imageName == "book" {
            let objectRect = CGRect(x: objectPositions[index].position.x, y: objectPositions[index].position.y, width: 100, height: 100)
            
            if objectRect.intersects(yellowBin) {
                withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                    objectPositions[index].opacity = 0.0
                }
                numberOfSolvedImages += 1
                
                soundManager.playSoundEffect(soundName: "correct", type: "mp3")
            } else {
                objectPositions[index].position = initialPositionFor(index: index)
                soundManager.playSoundEffect(soundName: "wrong", type: "mp3")
            }
        }
        //green bin
        if objectPositions[index].imageName == "keju" || objectPositions[index].imageName == "orangefruit" {
            let objectRect = CGRect(x: objectPositions[index].position.x, y: objectPositions[index].position.y, width: 100, height: 100)
            
            if objectRect.intersects(greenBin) {
                withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                    objectPositions[index].opacity = 0.0
                }
                numberOfSolvedImages += 1
                
                soundManager.playSoundEffect(soundName: "correct", type: "mp3")
            } else {
                objectPositions[index].position = initialPositionFor(index: index)
                soundManager.playSoundEffect(soundName: "wrong", type: "mp3")
            }
        }
        
        
        
    }
    
    func initialPositionFor(index: Int) -> CGPoint {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let x = CGFloat.random(in: 0...(screenWidth - 100))
        let y = CGFloat.random(in: 0...(screenHeight - 100))
        return CGPoint(x: x, y: y)
    }
        
    func checkWinCondition() {
        if(numberOfImages == numberOfSolvedImages){
            isGameWon = true
            soundManager.stopBackgroundMusic()
            soundManager.playSoundEffect(soundName: "win", type: "mp3")
        }
    }
}


struct CollectTheWasteView_Previews: PreviewProvider {
    static var previews: some View {
        CollectTheWasteView()
            .environmentObject(SoundManager())
    }
}

