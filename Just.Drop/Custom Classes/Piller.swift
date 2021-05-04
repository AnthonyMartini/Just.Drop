//
//  Piller.swift
//  Just.Drop
//
//  Created by Tony Martini on 5/3/21.
//


import Foundation
import SpriteKit

class Piller : SKSpriteNode{
    

    
   
    
    
    func Create(_ size : CGSize,_ pos :CGPoint,_ type: Bool,name : String,trgt : SKScene = MainMenu(), zpos : CGFloat = 1){
        self.size = size
        self.name = name
        zPosition = zpos
       
        if type == true{
            self.texture = SKTexture(imageNamed: "Good")
            
        }else{
            self.texture = SKTexture(imageNamed: "Bad")
        }
        position = pos
    }
    
}
