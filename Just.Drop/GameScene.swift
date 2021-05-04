//
//  GameScene.swift
//  Just.Drop
//
//  Created by Tony Martini on 4/30/21.
//This is a test

import Foundation
import SpriteKit

class GameScene : CScene{
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        //Create square
        let bounceSprite = SKSpriteNode()
        bounceSprite.color = .red
        bounceSprite.size = CGSize(width: 125 * multiplier, height: 125 * multiplier)
        bounceSprite.position = CGPoint(x: 0, y: 100 * multiplier)
        Cont.addChild(bounceSprite)
        
        //Create starting bars
        
        createPiller()
        
    }
    
    func createPiller(){
        print("Gay")
       let newpillar = Piller()
        newpillar.Create(CGSize(width: 100 * multiplier, height: 500 * multiplier), CGPoint(x: 0, y: 0), true, name: "Good")
        Cont.addChild(newpillar)
    }
    
    
}
