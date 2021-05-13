//
//  GameViewController.swift
//  Just.Drop
//
//  Created by Tony Martini on 4/29/21.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit
import UserNotifications
class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    
    var score = 0
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authplayer()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.sendScore), name: NSNotification.Name("SendScore"), object: nil)
 
        
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.checkScore), name: NSNotification.Name("CheckScore"), object: nil)
        
        
        /*
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.InterAd), name: NSNotification.Name("Inter"), object: nil)
         
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.presentvideoad), name: NSNotification.Name("video"), object: nil)
         
         */
        
        
        
    }
    
    //Game Center Stuff
    func authplayer(){
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                self.present(view!, animated: true, completion: nil)
            }else{
                print(GKLocalPlayer.local.isAuthenticated)
            }
        }
    }
    func savescore(_ number : Int){
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "HighScore")
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
    
    @objc func sendScore(){
        score = UserDefaults.standard.integer(forKey: "HighScore")
        savescore(score)
    }
    @objc func checkScore(){
        OpenGameCenter()
    }
    
    
    func OpenGameCenter(){
        let VC = self.view.window?.rootViewController
        let GCVC = GKGameCenterViewController()

        GCVC.gameCenterDelegate = self
        VC?.present(GCVC, animated: true, completion: nil)
    }
    
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
