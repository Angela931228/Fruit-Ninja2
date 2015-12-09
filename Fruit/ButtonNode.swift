//
//  ButtonNode.swift
//  Fruit
//
//  Created by 李骏 on 15/12/8.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class ButtonNode: SKSpriteNode
{
    var textureArr:[SKTexture] = [SKTexture]()
    
    init(arr:[SKTexture]){
        textureArr = arr
        let texture:SKTexture = arr[0]
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnDown()
    {
        let down = SKAction.setTexture(textureArr[1])
        let wait = SKAction.waitForDuration(2)
        let up = SKAction.setTexture(textureArr[0])
        //runAction(SKAction.sequence([down,wait,up]))
        runAction(down)
    }
    
    func btnUp(){
        let down = SKAction.setTexture(textureArr[1])
        let wait = SKAction.waitForDuration(2)
        let up = SKAction.setTexture(textureArr[0])
        //runAction(SKAction.sequence([down,wait,up]))
        runAction(up)
    }
    
}