//
//  Prize.swift
//  Fruit
//
//  Created by 李骏 on 15/12/7.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//

import AVFoundation
import Foundation
import SpriteKit
import UIKit

class Prize :Enemy
{
    
    init(pos:CGPoint) {
        super.init(enemyImageStr: image_prize)
        position = pos
        zPosition = Zposition.prize
        name = name_prize
        size = CGSize(width: size.width/2, height: size.height/2)
        setupPhysics()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setupPhysics() {
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.categoryBitMask = Category.Prize
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = Category.Rope
        physicsBody?.mass = 0.7
    }
    
    func setupRopeSegments(scene:SKScene,index:Int,width:CGFloat,height:CGFloat)
    {
        let file = ropeDataFile + String(index+1) + ".plist"
        let dataFile = NSBundle.mainBundle().pathForResource(file, ofType: nil)
        let ropes = NSArray(contentsOfFile: dataFile!) as! [NSDictionary]
        
        for i in 0..<ropes.count
        {
            let ropeData = ropes[i]
            let length  = Int(ropeData["length"] as! NSNumber) * Int(UIScreen.mainScreen().scale)
            let relAnchorPoint = CGPointFromString(ropeData["relAnchorPoint"] as! String)
            let anchorPoint = CGPoint(x: relAnchorPoint.x * width,y:relAnchorPoint.y * height)
            let idx = index*2 + i
            let rope = Rope(lengh: length, anchorpoint: anchorPoint,name: String(idx))
            rope.addToScene(scene)
            rope.attachToPrize(self)
        }
    }
}
