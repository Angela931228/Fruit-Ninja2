//
//  Menu.swift
//  Fruit
//
//  Created by 李骏 on 15/12/8.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import SpriteKit


class MenuScene: SKScene {
    
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    var buttons:[ButtonNode] = [ButtonNode]()
    
    
    override func didMoveToView(view: SKView) {
        width = (self.view?.frame.size.width)!
        height = (self.view?.frame.size.height)!
        
        setupBackground()
        creatEarth()
        creatTitle()
        creatPig()
        creatChat()
        creatBtns()
    }
    
    func setupBackground(){
        backgroundColor = UIColor.blackColor()
        
        let background = SKEmitterNode(fileNamed: "background.sks")
        background!.position = CGPoint(x: width/2, y: height/2)
        background!.zPosition = Zposition.background
        addChild(background!)
    }
    
    func creatEarth(){
        let earth = SKSpriteNode(imageNamed: image_earth)
        earth.position = CGPoint(x: width*0.32, y: height*0.2)
        earth.size = CGSize(width: earth.size.width*1.5, height: earth.size.height*1.5)
        earth.zPosition = Zposition.background
        addChild(earth)
        
        let rotate = SKAction.rotateByAngle(2, duration: 5)
        earth.runAction(SKAction.repeatActionForever(rotate), withKey: key_rotate_earth)
        
    }
    
    func creatPig(){
        let pig = AnimeNode(imageName: image_pig_1)
        pig.position = CGPoint(x: width*0.32, y: height*0.45)
        pig.size = CGSize(width: pig.size.width*0.9, height: pig.size.height*0.9)
        pig.zPosition = Zposition.planet
        let frames = [SKTexture(imageNamed: image_pig_1),
                        SKTexture(imageNamed: image_pig_3)]
        pig.setTextures(frames, delay: 0.3)
        addChild(pig)
    }
    
    func creatChat(){
        let chat = SKSpriteNode(imageNamed: image_chatbox)
        chat.position = CGPoint(x: width*0.18, y: height*0.7)
        chat.size = CGSize(width: chat.size.width*1.2, height: chat.size.height*1.2)
        chat.zPosition = Zposition.planet
        addChild(chat)
    }
    
    func creatTitle(){
        let title = SKSpriteNode(imageNamed: image_title)
        title.position = CGPoint(x: width*0.6, y: height*0.75)
        title.size = CGSize(width: title.size.width*1.2, height: title.size.height*1.2)
        title.zPosition = Zposition.label
        addChild(title)
        
        //let rotate = SKAction.rotateByAngle(2, duration: 5)
        //title.runAction(SKAction.repeatActionForever(rotate), withKey: key_rotate_earth)
    }
    
    func creatBtns(){
        for i in 0...2 {
            let btnY = CGFloat(height*0.48) - CGFloat(i*130)
            creatBtn(CGPoint(x: width*0.65, y: btnY),index: i)
        }
    }
    
    func creatBtn(pos:CGPoint,index:Int){
        let textures = [SKTexture(imageNamed: image_btn_blue_up),SKTexture(imageNamed: image_btn_blue_down)]
        let name = "btn_game_" + String(index)
        let btn = ButtonNode(arr: textures,btnName: name)
        btn.position = pos
        btn.setImageSize(0.8)
        btn.zPosition = Zposition.label
        addChild(btn)
        
        buttons.append(btn)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        
        
        for i in 0..<buttons.count {
            let btn:ButtonNode = buttons[i]
            if(btn.containsPoint(location)){
                btn.btnDown()
            }
        }
    }
    
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
//        let touch = touches!.first! as UITouch
//        let location = touch.locationInNode(self)
//        
//        let node = nodeAtPoint(location)
//        if((node.name) != nil){
//            print(node.name!)
//            let btn = node as! ButtonNode
//            btn.btnUp()
//        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        
        
        for i in 0..<buttons.count {
            let btn:ButtonNode = buttons[i]
            if(btn.containsPoint(location)){
                if((btn.name) != nil){
                    btn.btnUp()
                    switch btn.name! {
                    case name_btn_normalGame:
                        let gameScene = GameScene(size: self.size,idx: 5)
                        self.view?.presentScene(gameScene, transition: transitions[0])
                        break
                    case name_btn_timeGame:
                        break
                    case name_btn_diyGame:
                        //add diy camera
                        print("add camera photo")
                        
                        break
                    default:
                        break
                    }
                }
            }
        }
        

        
        
    }
    
    
    
    

    
    
    
}
