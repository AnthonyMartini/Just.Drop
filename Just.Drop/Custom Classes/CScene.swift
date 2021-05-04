//
//  CScene.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/12/21.
//wowowow

import Foundation
import SpriteKit
class CScene : SKScene{
    
    var multiplier : CGFloat = 0
    var heightmultiplier : CGFloat = 0
    var Cont = SKSpriteNode()
    var screenHeight : CGFloat = 0
    var screenWidth : CGFloat = 0
    var ratio : CGFloat = 0
    var adCounted = 0
    
    
    override func didMove(to view: SKView) {
        
        adCounted = UserDefaults.standard.integer(forKey: "AdsCounted")
        
        //Typical Scene Load Stuff, should probably move to its own class
        backgroundColor = .cyan
        anchorPoint = CGPoint(x: 0, y: 0)
        screenHeight = UIScreen.main.nativeBounds.height
        screenWidth = UIScreen.main.nativeBounds.width
        ratio = screenWidth/screenHeight
        print(UIScreen.main.nativeBounds)
        heightmultiplier = screenHeight / 1000
        
        scene?.size = UIScreen.main.nativeBounds.size
        if ratio > 0.6{
            print("wide")
            Cont.size.height = (scene?.size.height)!
            Cont.size.width = Cont.size.height * 0.6
            multiplier = Cont.size.height / 1000
        }
        if ratio < 0.6{
            print("Tall")
            Cont.size.width = (scene?.size.width)!
            Cont.size.height = Cont.size.width / 0.6
            multiplier = Cont.size.width / 600
        }

        Cont.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        Cont.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(Cont)
        
    }

    func moveScenes(_ targetScene : SKScene){
        let newScene = targetScene
        newScene.scaleMode = self.scaleMode
        let animation = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(newScene, transition: animation)
    }

    func AdCounter(){
        print(adCounted)
        if adCounted == 3{
            adCounted = 1
            UserDefaults.standard.set(adCounted, forKey: "AdsCounted")
            NotificationCenter.default.post(name: NSNotification.Name("Inter"), object: nil)
        }else{
            adCounted = adCounted + 1
            UserDefaults.standard.set(adCounted, forKey: "AdsCounted")
        }
    }
    func createLabel(_ object : SKLabelNode,_ fontSize: CGFloat,_ position : CGPoint,font : String = "Verdana",color : UIColor = .black,zpos : CGFloat = 1,alpha : CGFloat = 1,prefW : CGFloat = 1000 , numLine:Int = 1){
        object.fontSize = fontSize
        object.position = position
        object.fontName = font
        object.fontColor = color
        object.zPosition = zpos
        object.alpha = alpha
        object.preferredMaxLayoutWidth = prefW
        object.numberOfLines = numLine
        Cont.addChild(object)
    }

}

