//
//  RopeNode.swift
//  Cut the Rope
//
//  Created by yinxueyu on 11/27/15.
//  Copyright © 2015 yinxueyu. All rights reserved.
//
import Foundation
import SpriteKit
import UIKit

class Rope :SKNode
{
    var length:Int = 0
    var anchorPoint: CGPoint
    var ropeSegments: [SKNode] = []
    var isCut:Bool = false
    
    init(lengh:Int,anchorpoint:CGPoint,name:String)
    {
        self.length = lengh
        self.anchorPoint = anchorpoint
        
        super.init()
        self.name = name_rope + name
        isCut = false
        zPosition = Zposition.rope
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeInteger(length, forKey: "length")
        aCoder.encodeCGPoint(anchorPoint, forKey: "anchorPoint")
        
        super.encodeWithCoder(aCoder)
    }
    
    func setupRopeHolder(){
        let ropeHolder = SKSpriteNode(imageNamed: ropeHolderImage)
        ropeHolder.position = anchorPoint
        
        ropeSegments.append(ropeHolder)
        addChild(ropeHolder)
        
        ropeHolder.physicsBody = SKPhysicsBody(circleOfRadius: ropeHolder.size.width / 2)
        ropeHolder.physicsBody?.dynamic = false
        ropeHolder.physicsBody?.categoryBitMask = Category.RopeHolder
        ropeHolder.physicsBody?.collisionBitMask = 0
        ropeHolder.physicsBody?.contactTestBitMask = Category.Prize
    }
    
    func setupRopeSegments(){
        for i in 0..<length{
            let ropeSegment = SKSpriteNode(imageNamed: ropeTextureImage)
            let offset = ropeSegment.size.height * CGFloat(i + 1)
            ropeSegment.position = CGPointMake(anchorPoint.x,anchorPoint.y - offset)
            ropeSegment.name = name
            
            ropeSegments.append(ropeSegment)
            addChild(ropeSegment)
            
            ropeSegment.physicsBody = SKPhysicsBody(rectangleOfSize: ropeSegment.size)
            ropeSegment.physicsBody?.dynamic = true
            ropeSegment.physicsBody?.categoryBitMask = Category.Rope
            ropeSegment.physicsBody?.collisionBitMask = 0
            ropeSegment.physicsBody?.contactTestBitMask = Category.Prize
        }
    }
    
    func setupJoint(scene:SKScene){
        for i in 1...length
        {
            let nodeA = ropeSegments[i-1]
            let nodeB = ropeSegments[i]
            let joint = SKPhysicsJointPin.jointWithBodyA(
                nodeA.physicsBody!,
                bodyB: nodeB.physicsBody!,
                anchor:CGPointMake(CGRectGetMidX(nodeA.frame),CGRectGetMinY(nodeA.frame)))
            
            scene.physicsWorld.addJoint(joint)
        }
    }
    
    func addToScene(scene:SKScene)
    {
        scene.addChild(self)
        
        setupRopeHolder()
        setupRopeSegments()
        setupJoint(scene)

    }

    func attachToPrize(prize:SKSpriteNode)
     {
         let lastNode = ropeSegments.last!
         lastNode.position = CGPointMake(prize.position.x, prize.position.y + prize.size.height * 0.1)
        
         let joint = SKPhysicsJointPin.jointWithBodyA(lastNode.physicsBody!, bodyB: prize.physicsBody!, anchor: lastNode.position)
         prize.scene?.physicsWorld.addJoint(joint)
     }


    func cut(){
        //node.removeFromParent()
        isCut = true
        let fadeAway = SKAction.fadeOutWithDuration(0.25)
        let removeNode = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeAway,removeNode])
        
        runAction(sequence)
    }












}