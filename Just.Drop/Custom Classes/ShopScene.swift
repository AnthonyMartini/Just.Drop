//
//  ShopScene.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/12/21.
//

import Foundation
import SpriteKit
class ShopScene : CScene{
    
    var firstTouch = ""
    var ShopButtons = Array<ShopButton>()
    var ShopLabels = Array<SKLabelNode>()
    var stashLabel = SKLabelNode()
    var stash = 0
    
    func buySomething(_ button : ShopButton){
        
        
    }
    
    func updateStash(){
        stashLabel.text = String("Stash: \(stash)")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        NotificationCenter.default.addObserver(self, selector: #selector(ShopScene.AdPlayed), name: NSNotification.Name("Update"), object: nil)
    }
    @objc func AdPlayed(){
        stash = UserDefaults.standard.integer(forKey: "Stash")
        updateStash()
    }
    
}
