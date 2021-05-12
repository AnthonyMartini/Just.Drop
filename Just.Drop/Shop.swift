//
//  SquareShop.swift
//  Just.Drop
//
//  Created by Tony Martini on 5/5/21.
//

import SpriteKit
import GameplayKit

class Shop: ShopScene{
    
    var backButton = MenuButton()
    var VideoButton = MenuButton(imageNamed: "Video")
    var chosenSquare = ""
    
    var chosenNode = SKSpriteNode()

    
    var colors = [
        ["Blue",150,CGFloat(0),CGFloat(250)],
        ["Green",150,CGFloat(191.67),CGFloat(250)],
        
        ["Orange",150,CGFloat(-191.67),CGFloat(20)],
        ["Yellow",150,CGFloat(0),CGFloat(20)],
        ["Cyan",150,CGFloat(191.67),CGFloat(20)],
        
        ["Purple",150,CGFloat(-191.67),CGFloat(-210)],
        ["Magenta",150,CGFloat(0),CGFloat(-210)],
        ["Black",150,CGFloat(191.67),CGFloat(-210)]
    
    ]
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Labels
        let Title = SKLabelNode(text: "Squares")
        createLabel(Title, 70 * multiplier, CGPoint(x: 0, y: 450 * multiplier),font: "Verdana-Bold",color: .white)
        
        //Need to find out what word I used for Just.Drop original
        
        stash = UserDefaults.standard.integer(forKey: "Coins")
        
        //remove
        stash = 200
        stashLabel = SKLabelNode(text: "Stash: \(stash) Coins")
        createLabel(stashLabel, 35 * multiplier, CGPoint(x: 0, y: 375 * multiplier),font: "Verdana-Bold",color: .white)
        
      
        
        //Buttons -- Change Buttons Destinations
        
        backButton = MenuButton(imageNamed: "Back")
        backButton.Create(CGSize(width: 200 * multiplier, height: 100 * multiplier), CGPoint(x: 0 * multiplier, y: -420 * multiplier),name: "Back", trgt: MainMenu(size: self.size))
       
        Cont.addChild(backButton)
        
        
        //red Square
        let redSquare = ShopButton(imageNamed: "Red")
        redSquare.Create(CGSize(width: 150 * multiplier, height: 150 * multiplier), CGPoint(x: -191.67 * multiplier, y: 250 * multiplier), "Red", 0, true,"Red")
        Cont.addChild(redSquare)
        ShopButtons.append(redSquare)
        
        
        //Chosen Node Stuff
        chosenNode = SKSpriteNode(imageNamed: "Chosen")
        chosenNode.size = CGSize(width: 170 * multiplier, height: 170 * multiplier)
        Cont.addChild(chosenNode)
        
        let SquareColor = UserDefaults.standard.string(forKey: "SquareColor") ?? "Red"
        if SquareColor == "Red"{
            chosenSquare = "Red"
            chosenNode.position = CGPoint(x: redSquare.position.x, y: redSquare.position.y)
        }
        
        
        
        for Object in colors{
            let name = Object[0] as! String
            let cost = Object[1] as! Int
            let xpos = Object[2] as! CGFloat
            let ypos = Object[3] as! CGFloat
            
            
            
            let bought = UserDefaults.standard.bool(forKey: "\(name)Bought")
            let chosen = UserDefaults.standard.string(forKey: "SquareColor") ?? "Red"
            let ShopLabel = SKLabelNode(text: String(cost))
            //Create Shop Item and check to see if it's bought already
            var ShopItem = ShopButton()
            
            if bought == true{
                ShopItem = ShopButton(imageNamed: name)
            }else{
                ShopItem = ShopButton(imageNamed: "\(name)Locked")
                //Create Shop Label
                
                createLabel(ShopLabel, 25 * multiplier, CGPoint(x: xpos * multiplier, y: (ypos - 120) * multiplier),font: "Verdana-Bold")
            }
            
            //Creates it using array
            ShopItem.Create(CGSize(width: 150 * multiplier, height: 150 * multiplier), CGPoint(x: xpos * multiplier, y: ypos * multiplier), name, cost, bought, name,label: ShopLabel)
            Cont.addChild(ShopItem)
            ShopButtons.append(ShopItem)
            

            if chosen == name{
                chosenSquare = chosen
                chosenNode.position = CGPoint(x: ShopItem.position.x, y: ShopItem.position.y)
            }
            
        }
    }
    
    
    override func buySomething(_ button: ShopButton) {
        AdCounter()
        
        if stash >= button.cost{
            print("Bought")
            stash -= button.cost
            updateStash()
            button.costLabel.removeFromParent()
            button.bought = true
            UserDefaults.standard.setValue(stash, forKey: "Coins")
            
            chosenSquare = button.imagename
            UserDefaults.standard.setValue(chosenSquare, forKey: "SquareColor")
            UserDefaults.standard.setValue(true, forKey: "\(button.imagename)Bought")
            chosenNode.run(SKAction.move(to: CGPoint(x: button.position.x, y: button.position.y), duration: 0.4))
            
            
            button.texture = SKTexture(imageNamed: button.imagename)
            
        }else{
            stashLabel.run(SKAction.sequence([
                SKAction.scale(by: 1.5, duration: 0.5),
                SKAction.scale(by: 0.666666666667, duration: 0.5)
            ]))
        }
        
        
        
        
    }
    
    
    
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            
            if backButton.contains(pos){
                firstTouch = "Back"
                backButton.fadeOut()
            }
            for button in ShopButtons{
                if button.contains(pos){
                    button.fadeOut()
                    firstTouch = button.name ?? "Red"
                }
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
            
            for button in ShopButtons{
                if button.contains(pos) && firstTouch == button.name{
                    //Checks to see if button has been bought, if not, selects button
                    if button.bought == false{
                        buySomething(button)
                    }else{
                            chosenSquare = button.imagename
                            UserDefaults.standard.setValue(chosenSquare, forKey: "SquareColor")
                            chosenNode.run(SKAction.move(to: CGPoint(x: button.position.x, y: button.position.y), duration: 0.4))
                        
                    }
                    
                    
                }
                
                button.fadeIn()
            }
        }
    }
   
    
    
}
