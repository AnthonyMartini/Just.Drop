//
//  MenuScene.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/5/21.
//

import Foundation
import SpriteKit

class MenuScene : CScene{
    
    var MenuButtons = Array<MenuButton>()
    var firstTouch = ""
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            for i in MenuButtons{
                if i.contains(pos){
                    firstTouch = i.name!
                    i.fadeOut()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            for i in MenuButtons{
                if i.contains(pos) && firstTouch == i.name{
                    moveScenes(i.targetScene)
                }
                i.fadeIn()
            }
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for button in MenuButtons{
            button.fadeIn()
        }
        
    }
}
