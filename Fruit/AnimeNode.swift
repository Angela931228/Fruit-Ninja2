//
//  AnimeNode.swift
//  Fruit
//
//  Created by 李骏 on 15/12/8.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//

import Foundation

import AVFoundation
import Foundation
import SpriteKit
import UIKit

class AnimeNode :SKSpriteNode
{
    var textureArr:[SKTexture] = [SKTexture]()
    
    init(imageName:String) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        zPosition = Zposition.background
        
    }
    
    func setTextures(textures:[SKTexture],delay:Double){
        textureArr = textures
        animate(delay)
    }
    
    func animate(delay:Double){
        let move = SKAction.animateWithTextures(textureArr, timePerFrame: delay)
        runAction(SKAction.repeatActionForever(move), withKey: "anime")
    }


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

