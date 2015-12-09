//
//  DirectorScene.swift
//  Fruit
//
//  Created by 李骏 on 15/12/8.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import SpriteKit


class DirectorScene: SKScene {
    
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    

    override func didMoveToView(view: SKView) {
        width = (self.view?.frame.size.width)!
        height = (self.view?.frame.size.height)!
        
        let scene = MenuScene(size: self.size)
        self.view?.presentScene(scene, transition: transitions[0])
    }
    

}

