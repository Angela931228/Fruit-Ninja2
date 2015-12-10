//
//  Enemy.swift
//  Fruit
//
//  Created by 李骏 on 15/12/7.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//
import AVFoundation
import Foundation
import SpriteKit
import UIKit

class Enemy :SKSpriteNode
{
    var soundEffectPlayer: AVAudioPlayer!
    
    var emitter:SKEmitterNode?
    
    var type:String = ""
    var randomYVelocity:Int = 0
    var randomXVelocity:Int = 0
    var randomAngularVelocity:CGFloat = 0
    var isCut:Bool = false
    
    init(enemyImageStr:String) {
        type = enemyImageStr
        let texture = SKTexture(imageNamed: enemyImageStr)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMovement(min:Int,max:Int){
        setupRandomPosition(min,max: max)
        setupPhysics()
        playStartSoundEffect()
        setupType()
    }
    
    func checkSelf(){
        let wait = SKAction.waitForDuration(0.2)
        let check = SKAction.runBlock({
            if(self.position.y>200){
                self.physicsBody!.collisionBitMask = Category.earth
                self.removeActionForKey("check")
            }
        })
        
        let seq = SKAction.sequence([wait,check])
        runAction(seq, withKey: "check")
    }
    
    func setupRandomPosition(min:Int,max:Int){
        let randomPosition = CGPoint(x: RandomInt(min: min, max: max), y: -40)
        position = randomPosition
        
        randomAngularVelocity = CGFloat(RandomInt(min: -6, max: 6))/2.0

        if randomPosition.x<256{
            randomXVelocity = RandomInt(min: 3, max: 10)
        }else if randomPosition.x < 512{
            randomXVelocity = RandomInt(min: 1, max: 3)
        }else if randomPosition.x < 768{
            randomXVelocity = -RandomInt(min: 1, max: 3)
        }else {
            randomXVelocity = -RandomInt(min: 3, max: 10)
        }
        
        randomYVelocity = RandomInt(min: 24, max: 30)
    }
    
    func setupPhysics(){
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody!.velocity = CGVector(dx: randomXVelocity * 40, dy: randomYVelocity * 40)
        physicsBody?.restitution = 1.0
        physicsBody!.angularVelocity = randomAngularVelocity
        physicsBody!.categoryBitMask = Category.enemy
        
        
    
    }
    
    
    func setupType(){
        switch type {
        case image_bomb:
            name = name_bomb
            physicsBody!.contactTestBitMask = 0
            physicsBody!.collisionBitMask =  Category.earth
            //            emitter = SKEmitterNode(fileNamed: "sliceFuse.sks")!
            //            emitter!.position = CGPoint(x: 76, y: 64)
            //            addChild(emitter!)
            break
        default:
            name = name_enemy
            physicsBody!.contactTestBitMask = Category.earth
            physicsBody!.collisionBitMask = Category.enemy
            break
        }
        
    }
    
    
    func cut(){
        if(type == image_bomb){
            creatExplodeEffect(bombCutEffect)
        }else{
            creatExplodeEffect(enemyCutEffect)
        }
        playEndSoundEffect()
        removeCutedNode()
    }
    
    
    
    func creatExplodeEffect(effect:String){
        emitter = SKEmitterNode(fileNamed: effect)!
        emitter!.position = position
        parent!.addChild(emitter!)
    }
    

    
    func removeCutedNode(){
        physicsBody!.dynamic = false
        
        let scaleOut = SKAction.scaleTo(0.001, duration: 0.2)
        let fadeOut = SKAction.fadeOutWithDuration(0.2)
        let group = SKAction.group([scaleOut,fadeOut])
        let remove = SKAction.runBlock({self.removeFromParent()})
        
        let wait = SKAction.waitForDuration(3)
        let removeEmitter = SKAction.runBlock({
            if((self.emitter) != nil){
                self.emitter!.removeFromParent()
            }
        })

        
        let seq = SKAction.sequence([group,remove,wait,removeEmitter])
        runAction(seq)
        
    }
    
    
    override func removeFromParent() {
        super.removeFromParent()
        removeAllActions()
        if((soundEffectPlayer) != nil){
            soundEffectPlayer.stop()
        }
    }
    
    func playStartSoundEffect(){
        if(type == image_bomb){
            if soundEffectPlayer != nil {
                soundEffectPlayer.stop()
                soundEffectPlayer = nil
            }
            
            let path = NSBundle.mainBundle().pathForResource("sliceBombFuse.caf", ofType: nil)!
            let url = NSURL(fileURLWithPath: path)
            let sound = try! AVAudioPlayer(contentsOfURL: url)
            soundEffectPlayer = sound
            soundEffectPlayer.play()
        }else{
            runAction(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
        }
    }
    
 
    
    func playEndSoundEffect(){
        if(!isCut){
            if(type == image_bomb){
                runAction(SKAction.playSoundFileNamed("explosion.caf", waitForCompletion: false))
            }else{
                runAction(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }
            isCut = true
        }
    }
    
    
    
    
    

    

}