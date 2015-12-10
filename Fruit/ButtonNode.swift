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

class ButtonNode: SKNode
{
    var textureArr:[SKTexture] = [SKTexture]()
    var textForBtn:String = ""
    
    var image:SKSpriteNode = SKSpriteNode()
    var label:SKLabelNode = SKLabelNode()
    
    init(arr:[SKTexture],btnName:String,text:String="test"){
        textureArr = arr
        textForBtn = text
        super.init()
        self.name = btnName
        setupImage()
        setupLabel(textForBtn)

    }
    
    func setupImage(){
        image = SKSpriteNode(texture: textureArr[0])
        label.zPosition = 0.0
        addChild(image)
    }
    
    func setupLabel(text:String){
        label = SKLabelNode(text: text)
        label.fontName = "Impact"
        label.fontSize = 50
        label.position = CGPoint(x: 0, y: -5)
        label.zPosition = 1.0
        addChild(label)
    }
    
    func setImageSize(scale:CGFloat){
        image.size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
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
        image.runAction(down)
    }
    
    func btnUp(){
        let down = SKAction.setTexture(textureArr[1])
        let wait = SKAction.waitForDuration(2)
        let up = SKAction.setTexture(textureArr[0])
        //runAction(SKAction.sequence([down,wait,up]))
        image.runAction(up)
    }
    
}