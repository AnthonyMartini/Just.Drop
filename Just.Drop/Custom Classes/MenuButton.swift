//
//  Button.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/5/21.
//

import Foundation
import SpriteKit

class MenuButton : SKSpriteNode{
    
    var targetScene : SKScene
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        self.targetScene = SKScene()
        super.init(texture: texture,color: color,size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func fadeOut(){
        self.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))
    }
    func fadeIn(){
        self.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
    }
    
    func float(_ wait : CGFloat){
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: TimeInterval(wait)),
            SKAction.repeatForever(SKAction.sequence([
                SKAction.moveBy(x: 0, y: 10, duration: 0.6),
                SKAction.moveBy(x: 0, y: -20, duration: 0.6),
                SKAction.moveBy(x: 0, y: 10, duration: 0.6)
            
            ]))
        ]))
    }
    
    func Create(_ size : CGSize,_ pos :CGPoint,name : String,trgt : SKScene = MainMenu(), zpos : CGFloat = 1){
        self.size = size
        self.name = name
        zPosition = zpos
        targetScene = trgt
        position = pos
    }
    
}
