//
//  ShopButton.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/13/21.
//

import Foundation


import SpriteKit

class ShopButton : SKSpriteNode{
    
    var cost = 0
    var bought = false
    var imagename = ""
    var costLabel = SKLabelNode()
    
    func Create(_ size : CGSize,_ pos :CGPoint,_ name : String,_ cost :Int,_ bought : Bool,_ image : String, label : SKLabelNode = SKLabelNode(), zpos : CGFloat = 1){
        self.size = size
        self.name = name
        self.bought = bought
        zPosition = zpos
        self.cost = cost
        self.imagename = image
        self.costLabel = label
        position = pos
    }
    func fadeOut(){
        self.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))
    }
    func fadeIn(){
        self.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
    }
    
    func Bob(_ wait : TimeInterval){
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: wait),
            SKAction.repeatForever(SKAction.sequence([
                SKAction.moveBy(x: 0, y: 5, duration: 0.2),
                SKAction.moveBy(x: 0, y: -10, duration: 0.2),
                SKAction.moveBy(x: 0, y: 5, duration: 0.2),
                SKAction.wait(forDuration: 8.4)
            ]))
        
        
        ]))
        
        
    }
    
}
