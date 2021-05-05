//
//  UpgradesShop.swift
//  Just.Drop
//
//  Created by Tony Martini on 5/5/21.
//

import SpriteKit
import GameplayKit

class UpgradesShop: ShopScene{
    
    var backButton = MenuButton()
    

    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Labels
        let Title = SKLabelNode(text: "Upgrades")
        createLabel(Title, 70 * multiplier, CGPoint(x: 0, y: 450 * multiplier),font: "Verdana-Bold",color: .white)
        
        //Need to find out what word I used for Just.Drop original
        
        stash = UserDefaults.standard.integer(forKey: "Stash")
        stashLabel = SKLabelNode(text: "Stash: \(stash) Coins")
        createLabel(stashLabel, 35 * multiplier, CGPoint(x: 0, y: 375 * multiplier),font: "Verdana-Bold",color: .white)
        
      
        
        //Buttons -- Change Buttons Destinations
        
        backButton = MenuButton(imageNamed: "Back")
        backButton.Create(CGSize(width: 200 * multiplier, height: 100 * multiplier), CGPoint(x: 0 * multiplier, y: -400 * multiplier),name: "Back", trgt: MainMenu(size: self.size))
       
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
                moveScenes(ShopMenu())
            }
        }
    }
   
    
    
}
