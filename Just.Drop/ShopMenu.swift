//
//  ShopMenu.swift
//  Just.Drop
//
//  Created by Tony Martini on 5/5/21.
//

import SpriteKit
import GameplayKit

class ShopMenu: MenuScene{
    
    var stash = 0
    

    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Labels
        let Title = SKLabelNode(text: "Shop")
        createLabel(Title, 70 * multiplier, CGPoint(x: 0, y: 450 * multiplier),font: "Verdana-Bold",color: .white)
        
        //Need to find out what word I used for Just.Drop original
        
        stash = UserDefaults.standard.integer(forKey: "Stash")
        let stashLabel = SKLabelNode(text: "Stash: \(stash) Coins")
        createLabel(stashLabel, 35 * multiplier, CGPoint(x: 0, y: 375 * multiplier),font: "Verdana-Bold",color: .white)
        
      
        
        //Buttons -- Change Buttons Destinations
        
        let backButton = MenuButton(imageNamed: "Back")
        backButton.Create(CGSize(width: 200 * multiplier, height: 100 * multiplier), CGPoint(x: 0 * multiplier, y: -400 * multiplier),name: "Back", trgt: MainMenu(size: self.size))
        MenuButtons.append(backButton)
        Cont.addChild(backButton)
        
        
        let subtitle1 = SKLabelNode(text: "Squares")
        createLabel(subtitle1, 40 * multiplier, CGPoint(x: -150 * multiplier, y: 150 * multiplier),font: "Verdana-Bold",color: .white)
        
        let colorsButton = MenuButton(imageNamed: "Squares")
        colorsButton.Create(CGSize(width: 250 * multiplier, height: 250 * multiplier), CGPoint(x: -150 * multiplier, y: 0 * multiplier), name: "Shop", trgt: SquareShop(size: self.size))
        MenuButtons.append(colorsButton)
        Cont.addChild(colorsButton)
        
        
        let subtitle2 = SKLabelNode(text: "Upgrades")
        createLabel(subtitle2, 40 * multiplier, CGPoint(x: 150 * multiplier, y: 150 * multiplier),font: "Verdana-Bold",color: .white)
        
        let upgradesButton = MenuButton(imageNamed: "Upgrades")
        upgradesButton.Create(CGSize(width: 250 * multiplier, height: 250 * multiplier), CGPoint(x: 150 * multiplier * multiplier, y: 0 * multiplier), name: "Info", trgt: UpgradesShop(size: self.size))
        MenuButtons.append(upgradesButton)
        Cont.addChild(upgradesButton)
        
       
        
        
        
        
        
        
        
    }
   
    
    
}
