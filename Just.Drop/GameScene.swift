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
    
    var gameTimer = Timer()
    
    var ticks = 0
    var firsttouch = ""
    var jumpenabled = false
    var boostenabled = false
    
    //buttons
    var jumpButton = SKSpriteNode()
    var boostButton = SKSpriteNode()
    enum CategoryMask : UInt32 {
        case square = 0b00000001
        
        case good = 0b00000011
        case bad = 0b00000100

    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.physicsWorld.contactDelegate = self
        
        
        //Create square
        bounceSprite = SKSpriteNode()
        bounceSprite.color = .red
        bounceSprite.size = CGSize(width: 125 * multiplier, height: 125 * multiplier)
        bounceSprite.position = CGPoint(x: -100 * multiplier, y: 200 * multiplier)
        bounceSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 125 * multiplier, height: 125 * multiplier))
        bounceSprite.physicsBody?.affectedByGravity = true
        bounceSprite.physicsBody?.allowsRotation = false
        bounceSprite.physicsBody?.categoryBitMask = CategoryMask.square.rawValue
        Cont.addChild(bounceSprite)
        
        //Create starting bars
        
        createPiller(CGPoint(x: -212.5 * multiplier, y: 0 * multiplier),true)
        createPiller(CGPoint(x: 12.5 * multiplier, y: -200 * multiplier),true)
        createPiller(CGPoint(x: 237.5 * multiplier, y: -400 * multiplier),true)
        createPiller(CGPoint(x: 462.5 * multiplier, y: -600 * multiplier),true)
        
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
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameUpdate), userInfo: nil, repeats: true)
        
    }
    
    @objc func GameUpdate(){
        ticks += 1
        if ticks % 2 == 0{
            createPiller(CGPoint(x: 462.5 * multiplier, y: -600 * multiplier),true)
        }
        
        
    }
    
    func createPiller(_ pos: CGPoint,_ type: Bool){
       let newpillar = Piller()
        newpillar.Create(CGSize(width: 175 * multiplier, height: 17.5 * multiplier), pos, type, name: "Piller")
        Cont.addChild(newpillar)
        newpillar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 175 * multiplier, height: 17.5 * multiplier))
        newpillar.physicsBody?.isDynamic = false
        newpillar.physicsBody?.categoryBitMask = CategoryMask.good.rawValue
        newpillar.physicsBody?.contactTestBitMask = CategoryMask.square.rawValue
        newpillar.run(SKAction.sequence([SKAction.move(by: CGVector(dx: -900 * multiplier, dy: 800), duration: 6), SKAction.removeFromParent()]))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: self)
            
            if jumpButton.contains(pos){
                firsttouch = "Jump"
            }
            if boostButton.contains(pos){
                firsttouch = "Boost"
            }
 
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: self)
            
            if jumpButton.contains(pos) && firsttouch == "Jump" && jumpenabled == true{
                bounceSprite.physicsBody?.velocity = CGVector(dx: 0, dy: 100)
            }
        }
    }
    
    
}
