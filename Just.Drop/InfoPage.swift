//
//  InfoPage.swift
//  Just.Drop
//
//  Created by Tony Martini on 5/5/21.
//



import SpriteKit
import GameplayKit

class InfoPage: CScene{
    
    var backButton = MenuButton()
    var firstTouch = ""

    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Labels
        let Title = SKLabelNode(text: "Info")
        createLabel(Title, 70 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold",color: .white)
        
       //Start of Main Content
        let howToLabel = SKLabelNode(text: "How To Play")
        createLabel(howToLabel, 45 * multiplier, CGPoint(x: 0, y: 375 * multiplier),font: "Verdana-Bold",color: .white)
        
        let divider1 = SKSpriteNode()
        divider1.color = .white
        divider1.size = CGSize(width: 550 * multiplier, height: 5 * multiplier)
        divider1.position = CGPoint(x: 0, y: 340 * multiplier)
        Cont.addChild(divider1)
        
        let partOne = SKSpriteNode(imageNamed: "HowTo1")
        partOne.size = CGSize(width: 500 * multiplier, height: 150 * multiplier)
        partOne.position = CGPoint(x: 0, y: 250 * multiplier)
        Cont.addChild(partOne)
        
        let divider2 = SKSpriteNode()
        divider2.color = .white
        divider2.size = CGSize(width: 550 * multiplier, height: 5 * multiplier)
        divider2.position = CGPoint(x: 0, y: 160 * multiplier)
        Cont.addChild(divider2)
      
        let partTwo = SKSpriteNode(imageNamed: "HowTo2")
        partTwo.size = CGSize(width: 500 * multiplier, height: 175 * multiplier)
        partTwo.position = CGPoint(x: 0, y: 57.5 * multiplier)
        Cont.addChild(partTwo)
        
        let divider3 = SKSpriteNode()
        divider3.color = .white
        divider3.size = CGSize(width: 550 * multiplier, height: 5 * multiplier)
        divider3.position = CGPoint(x: 0, y: -45 * multiplier)
        Cont.addChild(divider3)
        
        let partThree = SKSpriteNode(imageNamed: "HowTo3")
        partThree.size = CGSize(width: 500 * multiplier, height: 175 * multiplier)
        partThree.position = CGPoint(x: 0, y: -147.5 * multiplier)
        Cont.addChild(partThree)
        
        
        let divider4 = SKSpriteNode()
        divider4.color = .white
        divider4.size = CGSize(width: 550 * multiplier, height: 5 * multiplier)
        divider4.position = CGPoint(x: 0, y: -250 * multiplier)
        Cont.addChild(divider4)
        
        //End of Main Content- - - - - - - - - - - - - - - - - - - -
        
        let contactEmail = SKLabelNode(text: "Contact Email: 1thenerdherd@gmail.com")
        createLabel(contactEmail, 20 * multiplier, CGPoint(x: 0, y: -350 * multiplier),font: "Verdana-Bold",color: .white)
        
        backButton = MenuButton(imageNamed: "GotIt")
        backButton.Create(CGSize(width: 140 * multiplier, height: 70 * multiplier), CGPoint(x: 0 * multiplier, y: -425 * multiplier),name: "Back", trgt: MainMenu(size: self.size))
       
        Cont.addChild(backButton)
        
        
        
        
        
        
        
        
       
        
        
        
        
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            
            if backButton.contains(pos){
                firstTouch = "Back"
                backButton.fadeOut()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            if backButton.contains(pos) && firstTouch == "Back"{
                moveScenes(MainMenu())
            }
            backButton.fadeIn()
        }
    }
   
    
    
}

