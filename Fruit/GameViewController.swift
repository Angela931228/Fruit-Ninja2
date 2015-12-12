//
//  GameViewController.swift
//  Fruit
//
//  Created by 戢婧祎 on 28/11/15.
//  Copyright (c) 2015年 戢婧祎. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = MenuScene(fileNamed:"MenuScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    func switchToNewGameWithTransition(){
//        let index = RandomInt(min: 0, max: 11)
//        let delay = SKAction.waitForDuration(0.2)
//        let transition = SKAction.runBlock({
//            //let scene = GameScene(size: self.size)
//            self.view?.presentScene(scene, transition: self.transitions[index])
//        })
        
        //runAction(SKAction.sequence([delay,transition]), withKey: "transition")
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
