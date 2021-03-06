//
//  GameScene.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/4/21.
//

import SpriteKit
import GameplayKit

class MainMenu: MenuScene{

    var highScore = 0
    var playedBefore = false
    
    var leaderboardButton = MenuButton()
    
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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Labels
        let Title = SKLabelNode(text: "Just.Drop")
        createLabel(Title, 70 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold",color: .white)
        
        highScore = UserDefaults.standard.integer(forKey: "HighScore")
        let HighScoreLabel = SKLabelNode(text: "Best Score : \(highScore)")
        createLabel(HighScoreLabel, 35 * multiplier, CGPoint(x: 0, y: -80 * multiplier),font: "Verdana-Bold",color: .white)
        //Actions
        let up = SKAction.moveBy(x: 0, y: 150 * multiplier, duration: 0.4)
        let down = SKAction.moveBy(x: 0, y: -150 * multiplier, duration: 0.4)
        
        let squareColor = UserDefaults.standard.string(forKey: "SquareColor") ?? "Red"
        
        // Bouncing Square
        
        let bounceSprite = SKSpriteNode()
        bounceSprite.color = colors[squareColor] ?? .red
        bounceSprite.size = CGSize(width: 125 * multiplier, height: 125 * multiplier)
        bounceSprite.position = CGPoint(x: 0, y: 100 * multiplier)
        Cont.addChild(bounceSprite)
        
        bounceSprite.run(SKAction.repeatForever( SKAction.sequence([
            up,
            down,
            SKAction.wait(forDuration: 1)
            
        
        ])))
        
        
        //Buttons -- Change Buttons Destinations
        
        let playButton = MenuButton(imageNamed: "Play")
        playButton.Create(CGSize(width: 220 * multiplier, height: 110 * multiplier), CGPoint(x: 0, y: -175 * multiplier),name: "Play", trgt: GameScene(size: self.size))
        MenuButtons.append(playButton)
        Cont.addChild(playButton)
        
        let ShopButton = MenuButton(imageNamed: "Shop")
        ShopButton.Create(CGSize(width: 75 * multiplier, height: 75 * multiplier), CGPoint(x: 175 * multiplier, y: -175 * multiplier), name: "Shop", trgt: Shop(size: self.size))
        MenuButtons.append(ShopButton)

        Cont.addChild(ShopButton)
        
        let InfoButton = MenuButton(imageNamed: "Info")
        InfoButton.Create(CGSize(width: 75 * multiplier, height: 75 * multiplier), CGPoint(x: -175 * multiplier, y: -175 * multiplier), name: "Info", trgt: InfoPage(size: self.size))
        MenuButtons.append(InfoButton)
        Cont.addChild(InfoButton)
        
        
        leaderboardButton = MenuButton(imageNamed: "Leaderboard")
        leaderboardButton.Create(CGSize(width: 360 * multiplier, height: 90 * multiplier), CGPoint(x: 0, y: -300 * multiplier),name: "Play", trgt: GameScene(size: self.size))
        Cont.addChild(leaderboardButton)
       
        
        
        
        playedBefore = UserDefaults.standard.bool(forKey: "Before")
        if playedBefore == false{
            UserDefaults.standard.setValue(true, forKey: "Before")
            moveScenes(InfoPage())
        }
        
        
        
        
        
        
    }
    
    //Special case for main menu becuase of leaderboard button
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let pos = touch.location(in: Cont)
            
            if leaderboardButton.contains(pos){
                firstTouch = "Leader"
                leaderboardButton.fadeOut()
            }
           
        }
        super.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
           
            if leaderboardButton.contains(pos) && firstTouch == "Leader"{
                //Leaderboard Stuff
                NotificationCenter.default.post(name: NSNotification.Name("CheckScore"), object: nil)
            }
            leaderboardButton.fadeIn()
          
        }
        
        super.touchesEnded(touches, with: event)
        
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesCancelled(touches, with: event)
        
    }
    
}
