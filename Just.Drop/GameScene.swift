//
//  GameScene.swift
//  Just.Drop
//
//  Created by Tony Martini on 4/30/21.
//This is a test

import Foundation
import SpriteKit

class GameScene : CScene, SKPhysicsContactDelegate{
    
    var bounceSprite = SKSpriteNode()
    var circle = SKShapeNode()
    
    var gameTimer = Timer()
    
    var gameTick = 0.0
    var coinTick = 0
    var obstacleTick = 0
    
    
    var circleTick = 0
    var boostReady = false
    
    var gamesPlayed = 0
    
    var gameSpeed = 11.0
    var gameSpeedTemp = 11.0
    var obstacleFrequency = 9
    var obstacleRandom = 5
    var coinFrequency = 7
    var obstacleCountdown = 9
    var coinCountdown = 7
    
    var score = 0
    var coins = 0
    var coinLabel = SKLabelNode()
    var firsttouch = ""
    var jumpenabled = false
    var boostenabled = false
    
    var colors : [String: UIColor] = [
        "Red" : .red,
        "Blue" : .blue,
        "Green" : .green,
        "Yellow" : .yellow,
        "Orange" : .orange,
        "Purple" : .magenta,
        "Magenta" : .magenta,
        "Cyan" : .cyan,
        "Black" : .black,
    ]
    
    
    
    //buttons
    var jumpButton = SKSpriteNode()
    var boostButton = SKSpriteNode()
    
    var playAgain = SKSpriteNode()
    var mainMenu = SKSpriteNode()
    
    
    var scoreLabel = SKLabelNode()
    enum CategoryMask : UInt32 {
        case square = 0b00000001
        case good =   0b00000011
        case bad =    0b00000100
        case other =  0b00100000

    }
    
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.physicsWorld.contactDelegate = self
        
        gamesPlayed = UserDefaults.standard.integer(forKey: "GamesPlayed")
        gamesPlayed += 1
        UserDefaults.standard.setValue(gamesPlayed, forKey: "GamesPlayed")
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameUpdate), userInfo: nil, repeats: true)
        //Labels
        
        coins = UserDefaults.standard.integer(forKey: "Coins")
        coinLabel.text = "\(coins) coins"
        createLabel(coinLabel, 25 * multiplier, CGPoint(x: 200 * multiplier, y: 440 * multiplier),font: "Verdana-Bold",color: .white)
        
        scoreLabel = SKLabelNode(text: "0")
        createLabel(scoreLabel, 70 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold",color: .white)
        
        //Square Color:
        let squareColor = UserDefaults.standard.string(forKey: "SquareColor") ?? "Red"
        
        
        
        //Create square
        bounceSprite = SKSpriteNode()
        bounceSprite.color = colors[squareColor] ?? .red
        bounceSprite.size = CGSize(width: 125 * multiplier, height: 125 * multiplier)
        bounceSprite.position = CGPoint(x: -100 * multiplier, y: 200 * multiplier)
        bounceSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 125 * multiplier, height: 125 * multiplier))
        bounceSprite.physicsBody?.affectedByGravity = true
        bounceSprite.physicsBody?.allowsRotation = false
        bounceSprite.physicsBody?.categoryBitMask = CategoryMask.square.rawValue
        bounceSprite.physicsBody?.contactTestBitMask = CategoryMask.bad.rawValue | CategoryMask.good.rawValue | CategoryMask.other.rawValue
        bounceSprite.physicsBody?.collisionBitMask = CategoryMask.good.rawValue | CategoryMask.bad.rawValue
        Cont.addChild(bounceSprite)
        
        //Create starting bars
        
        createPiller(CGPoint(x: -212.5 * multiplier, y: 0 * multiplier),true)
        createPiller(CGPoint(x: 112.5 * multiplier, y: -266.667 * multiplier),true)
        createPiller(CGPoint(x: 412.5 * multiplier, y: -533.333 * multiplier),true)
        
        
        //Jump Buttons
        
        jumpButton = SKSpriteNode(imageNamed: "Jump")
        jumpButton.size = CGSize(width: 150 * multiplier, height: 150 * multiplier)
        jumpButton.position = CGPoint(x: -125 * multiplier, y: -350 * multiplier)
        jumpButton.zPosition = 4
        Cont.addChild(jumpButton)
        
        
        boostButton = SKSpriteNode(imageNamed: "Boost")
        boostButton.size = CGSize(width: 100 * multiplier, height: 100 * multiplier)
        boostButton.position = CGPoint(x: 125 * multiplier, y: -350 * multiplier)
        boostButton.zPosition = 4
        Cont.addChild(boostButton)
        
        circle = SKShapeNode(circleOfRadius: 50)
        circle.strokeColor = .red
        circle.lineWidth = 10 * multiplier
        Cont.addChild(circle)
        
        
        
    }
    
    @objc func GameUpdate(){
        
        gameTick += 1
        if boostReady == false{
            circleTick += 1
            let angle : CGFloat = .pi * CGFloat(circleTick) / 50
            circle.path = UIBezierPath(arcCenter: CGPoint(x: 125 * multiplier, y: -350 * multiplier), radius: CGFloat(50 * multiplier), startAngle: 0, endAngle: angle, clockwise: true).cgPath
            if circleTick == 100{
                boostReady = true
                circle.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 1), SKAction.fadeIn(withDuration: 1)])))
            }
        }
        
        
        
        
        
        if gameTick == gameSpeed {
            print(gameTick)
            print(obstacleTick)
            coinTick += 1
            obstacleTick += 1
            gameTick = 0
            gameSpeed = gameSpeedTemp
            if obstacleTick == obstacleCountdown{
                obstacleTick = 0
                obstacleCountdown = obstacleFrequency + Int.random(in: 0...obstacleRandom)
                createPiller(CGPoint(x: 562.5 * multiplier, y: -666.666 * multiplier),false)
                if coinTick == coinCountdown{
                    coinTick = 0
                    coinCountdown = coinFrequency + Int.random(in: 0...5)
                    
                }
            }else{
                if coinTick == coinCountdown{
                    coinTick = 1
                    coinCountdown = coinFrequency + Int.random(in: 0...5)
                    createCoin(CGPoint(x: 562.5 * multiplier, y: -626.666))
                }
                createPiller(CGPoint(x: 562.5 * multiplier, y: -666.666 * multiplier),true)
            }
        }
        
        
            
        
        
        
    }
   
    func createCoin(_ pos: CGPoint){
        
        let coin = SKSpriteNode(imageNamed: "Coin")
        coin.size = CGSize(width: 40 * multiplier, height: 40 * multiplier)
        coin.position = pos
        coin.name = "Coin"
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40 * multiplier, height: 40 * multiplier))
        coin.physicsBody?.isDynamic = false
        
        coin.physicsBody?.categoryBitMask = CategoryMask.other.rawValue
        
        Cont.addChild(coin)
        coin.run(SKAction.sequence([SKAction.move(by: CGVector(dx: -1200 * multiplier, dy: 1066.667), duration: TimeInterval(4 * (gameSpeed / 10))), SKAction.removeFromParent()]))
    }
    func updateScore(){
        score += 1
        scoreLabel.text = String(score)
        
        if score == 20{
            obstacleFrequency = 8
        }
        if score == 40{
            gameSpeedTemp = 10
        }
        if score == 60{
            obstacleFrequency = 7
        }
        if score == 80{
            obstacleRandom = 4
        }
        if score == 100{
            gameSpeedTemp = 9
        }
        if score == 120{
            obstacleFrequency = 7
        }
        if score == 140{
            gameSpeedTemp = 8
        }
        if score == 160{
            obstacleFrequency = 6
        }
        if score == 180{
            gameSpeedTemp = 7
        }
        if score == 200{
            obstacleRandom = 3
        }
        if score == 230{
            obstacleFrequency = 5
        }
        if score == 260{
            gameSpeedTemp = 6
        }
        if score == 300{
            gameSpeedTemp = 5
        }
        
    }
    func createPiller(_ pos: CGPoint,_ type: Bool){
       let newpillar = Piller()
        if type == false{
            //Obstacles
            newpillar.Create(CGSize(width: 175 * multiplier, height: 35 * multiplier), CGPoint(x: pos.x, y: pos.y - (8.75 * multiplier)), type, name: "Obstacle")
            
            newpillar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 175 * multiplier, height: 35 * multiplier))
            newpillar.physicsBody?.categoryBitMask = CategoryMask.bad.rawValue
        }else{
            //Normal
            
            newpillar.Create(CGSize(width: 175 * multiplier, height: 17.5 * multiplier), pos, type, name: "Piller")
            
            newpillar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 175 * multiplier, height: 17.5 * multiplier))
            newpillar.physicsBody?.categoryBitMask = CategoryMask.good.rawValue
        }
        
        Cont.addChild(newpillar)
        newpillar.physicsBody?.isDynamic = false
        newpillar.physicsBody?.contactTestBitMask = CategoryMask.square.rawValue
        newpillar.run(SKAction.sequence([SKAction.move(by: CGVector(dx: -1200 * multiplier, dy: 1066.667), duration: TimeInterval(4.0 * (gameSpeed / 10))), SKAction.removeFromParent()]))
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let conA = contact.bodyA.node
        let conB = contact.bodyB.node
    
        if conA?.name == "Coin"{
            conA?.removeFromParent()
            coins += 1
            UserDefaults.standard.setValue(coins, forKey: "Coins")
            coinLabel.text = "\(coins) coins"
        }
        if conB?.name == "Coin"{
            conB?.removeFromParent()
            coins += 1
            UserDefaults.standard.setValue(coins, forKey: "Coins")
            coinLabel.text = "\(coins) coins"
        }
        
        if conA?.name == "Piller" || conB?.name == "Piller"{
            jumpenabled = true
            updateScore()
            
        }
        
        if conA?.name == "Obstacle" || conB?.name == "Obstacle"{
            gameOver()
            
        }
    }
    
    func gameOver(){
        gameTimer.invalidate()
        
        //Turn off touches for a second or two
        self.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1400), execute: {
            self.isUserInteractionEnabled = true
        })
        
        for child in Cont.children{
            child.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 0.6), SKAction.removeFromParent()]))
            
        }
        
        if gamesPlayed == 4{
            AppStoreReviewManager.requestReviewIfAppropriate()
        }
        
        //New Objects
        
        
        let gameOverLabel = SKLabelNode(text: "Game Over")
        createLabel(gameOverLabel, 80 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold",color: .white,alpha: 0)
        gameOverLabel.run(SKAction.sequence([SKAction.wait(forDuration: 0.6),SKAction.fadeIn(withDuration: 0.6)]))
        
        
        let newScoreLabel = SKLabelNode(text: String(score))
        createLabel(newScoreLabel, 180 * multiplier, CGPoint(x: 0, y: 185 * multiplier),font: "Verdana-Bold",color: .white,alpha: 0)
        newScoreLabel.run(SKAction.sequence([SKAction.wait(forDuration: 0.6),SKAction.fadeIn(withDuration: 0.6)]))
        
        
        var highScore = UserDefaults.standard.integer(forKey: "HighScore")
        
        if score > highScore{
            highScore = score
            UserDefaults.standard.setValue(highScore, forKey: "HighScore")
            NotificationCenter.default.post(name: NSNotification.Name("SendScore"), object: nil)
        }
        
        let highscoreLabel = SKLabelNode(text: "HighScore: \(highScore)")
        createLabel(highscoreLabel, 30 * multiplier, CGPoint(x: 0, y: 100 * multiplier),font: "Verdana-Bold",color: .white,alpha: 0)
        highscoreLabel.run(SKAction.sequence([SKAction.wait(forDuration: 0.6),SKAction.fadeIn(withDuration: 0.6)]))
        
        //Play Again and Main Menu
        
        playAgain = SKSpriteNode(imageNamed: "PlayAgain")
        playAgain.size = CGSize(width: 200 * multiplier, height: 100 * multiplier)
        playAgain.position = CGPoint(x: -150 * multiplier, y: -300 * multiplier)
        playAgain.alpha = 0
        Cont.addChild(playAgain)
        playAgain.run(SKAction.sequence([SKAction.wait(forDuration: 0.6),SKAction.fadeIn(withDuration: 0.6)]))
        
        mainMenu = SKSpriteNode(imageNamed: "MainMenu")
        mainMenu.size = CGSize(width: 200 * multiplier, height: 100 * multiplier)
        mainMenu.position = CGPoint(x: 150 * multiplier, y: -300 * multiplier)
        mainMenu.alpha = 0
        Cont.addChild(mainMenu)
        mainMenu.run(SKAction.sequence([SKAction.wait(forDuration: 0.6),SKAction.fadeIn(withDuration: 0.6)]))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            if jumpButton.contains(pos){
                firsttouch = "Jump"
                jumpButton.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))

            }
            if boostButton.contains(pos){
                firsttouch = "Boost"
                boostButton.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))
            }
            
            if playAgain.contains(pos){
                firsttouch = "PlayAgain"
                playAgain.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))
            }
            if mainMenu.contains(pos){
                firsttouch = "MainMenu"
                mainMenu.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))
            }
 
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            if jumpButton.contains(pos) && firsttouch == "Jump" && jumpenabled == true{
                bounceSprite.physicsBody?.velocity = CGVector.zero
                bounceSprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 600 * multiplier))
                jumpenabled = false
            }
            
            //Boost Button
            
            if boostButton.contains(pos) && firsttouch == "Boost"{
                
                if boostReady == true{
                    circle.removeAllActions()
                    circle.alpha = 1
                    bounceSprite.physicsBody?.velocity = CGVector.zero
                    bounceSprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1900 * multiplier))
                    boostReady = false
                    circleTick = 0
                }
            }
            
            if playAgain.contains(pos) && firsttouch == "PlayAgain"{
                moveScenes(GameScene())
            }
            if mainMenu.contains(pos) && firsttouch == "MainMenu"{
                moveScenes(MainMenu())
            }
            playAgain.run(SKAction.fadeIn(withDuration: 0.3))
            mainMenu.run(SKAction.fadeIn(withDuration: 0.3))
            jumpButton.run(SKAction.fadeIn(withDuration: 0.3))
            boostButton.run(SKAction.fadeIn(withDuration: 0.3))
            
        }
    }
    
    
}
