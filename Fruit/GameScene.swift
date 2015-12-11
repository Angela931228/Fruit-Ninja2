//
//  GameScene.swift
//  Fruit
//
//  Created by 戢婧祎 on 28/11/15.
//  Copyright (c) 2015年 戢婧祎. All rights reserved.
//
import AVFoundation
import UIKit
import SpriteKit


class GameScene: SKScene,SKPhysicsContactDelegate{
    
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    
    var gameScoreLabel: SKLabelNode!
    var gameTipsLabel: SKLabelNode!
    var restart: SKLabelNode!
    var prize: SKSpriteNode!
    var prize1: SKSpriteNode!
    var earth:SKSpriteNode!
    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!
    
    var score: Int = 0 {
        didSet{
            gameScoreLabel.text = "Score: \(score)"
        }
    }
    
    var livesNodeArr = [SKSpriteNode]()
    var curLife = maxLife

    var activeSlicePoints = [CGPoint]()
    var swooshSoundActive = false
    var soundIndex:Int = 1
    var activeEnemies = [Enemy]()
    
    var waveArr: [SequenceType]!
    var wave = 0
    var chainDelay = 3.0
    var gameEnded = false
    var timer = NSTimer()

    var isGameEnd:Bool = false
    

//    override init(size: CGSize) {
//        super.init(size: size)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func didMoveToView(view: SKView) {
        width = (self.view?.frame.size.width)!
        height = (self.view?.frame.size.height)!

        setupPhysics()
        setupUI()

        createSlices()
        
        
    }
    

    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85
    }

    
    /*---------UI---------*/
    
    
    func setupUI(){
        setupBackground()
        creatEarth()
        createScore()
        createLives()
        creatStartNumber()
        
    }
    
    func setupBackground(){
        backgroundColor = UIColor.blackColor()
        
        let background = SKEmitterNode(fileNamed: "background.sks")
        background!.position = CGPoint(x: width/2, y: height/2)
        background!.zPosition = Zposition.background
        addChild(background!)
    }
    
    func creatStartNumber(){
        RunAfterDelay(1, block: {
            self.createTips("3")
            self.runScaleAction(self.gameTipsLabel)
        })
        
        RunAfterDelay(2, block: {
            self.gameTipsLabel.text = "2"
            self.runScaleAction(self.gameTipsLabel)
        })
        RunAfterDelay(3, block: {
            self.gameTipsLabel.text = "1"
            self.runScaleAction(self.gameTipsLabel)
        })
        RunAfterDelay(4, block: {
            self.gameTipsLabel.text = "start"
            self.runScaleAction(self.gameTipsLabel)
        })
        RunAfterDelay(5, block: {
            self.gameTipsLabel.text = ""
            self.startGame()
        })
    }
    
    func creatEarth(){
        earth = SKSpriteNode(imageNamed: image_earth)
        earth.position = CGPoint(x: width/2, y: 0)
        earth.zPosition = Zposition.background
        earth.name = name_earth
        addChild(earth)
        
        let rotate = SKAction.rotateByAngle(2, duration: 5)
        earth.runAction(SKAction.repeatActionForever(rotate), withKey: key_rotate_earth)
        
        
        earth.physicsBody = SKPhysicsBody(texture: earth.texture!, size: earth.size)
        earth.physicsBody?.categoryBitMask = Category.earth
        earth.physicsBody?.collisionBitMask = Category.enemy
        earth.physicsBody?.dynamic = false
        

    }

    
    func createScore() {
        gameScoreLabel = creatSkLabelNode("Score: 0", size: 45, position: CGPoint(x:20, y:20))
        gameScoreLabel.horizontalAlignmentMode = .Left
        addChild(gameScoreLabel)
    }
    
    func createTips(content: String){

        gameTipsLabel = creatSkLabelNode(content, size: 100, position: CGPoint(x:width/2, y:height/2))
        addChild(gameTipsLabel)
    }
    
    func createReStar(){
        restart = creatSkLabelNode("Restart", size: 50, position: CGPoint(x: width*0.15, y: height*0.8))
        restart.name = name_btn_restart
        addChild(restart)
        runScaleAction(restart)
    }
    
    func runScaleAction(node:SKNode){
        node.setScale(1.7)
        node.runAction(SKAction.scaleTo(1, duration: 0.5))
    }
    
    func creatSkLabelNode(text:String,size:CGFloat = 100,position:CGPoint) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Impact")
        label.text = text
        label.fontSize = size
        label.position = position
        label.zPosition = Zposition.labeltop
        return label
    }
    
    func createLives(){
        for i in 0 ..< 3 {
            let spriteNode = SKSpriteNode(imageNamed: image_life)
            spriteNode.size = CGSize(width: spriteNode.size.width/2, height: spriteNode.size.height/2)
            spriteNode.position = CGPoint(x: width*0.8+(CGFloat)(i*80), y: height*0.86)
            spriteNode.zPosition = Zposition.label
            addChild(spriteNode)
            livesNodeArr.append(spriteNode)
        }
    }
    
    /*---------UI end---------*/

    
    /*---------game logic ---------*/
    
    
    func addScore(num:Int){
        score+=num
        if score >= passScore_lv1{
            pass()
        }
    }
    
    
    func addLife(){
        if(curLife+1<=3){
            addLifeAnime()
            curLife++
            playSoundEffect("wrong.caf")
        }
    }
    

    
    func lostLife(){
        if(curLife-1>=0){
            
            lostLifeAnime()
            playSoundEffect("wrong.caf")
            curLife--
            
            if curLife == 1{
                setupPrizes()
                alwaysBomb()
            }else if curLife == 0 {
                dead()
            }
        }
    }
    
    func lostLifeAnime(){
        let life:SKSpriteNode = livesNodeArr[maxLife-curLife]
        setGrayColor(life)
        runScaleAction(life)
    }
    
    func addLifeAnime(){
        let life:SKSpriteNode = livesNodeArr[maxLife-curLife-1]
        clearColor(life)
        runScaleAction(life)
    }
    
    func setGrayColor(node:SKSpriteNode){
        node.color = SKColor.blackColor()
        node.colorBlendFactor = 0.6
    }
    
    func clearColor(node:SKSpriteNode){
        node.color = SKColor.clearColor()
        node.colorBlendFactor = 1
    }
    
    func startGame(){
        
        waveArr = [.OneNoBomb, .OneNoBomb, .TwoWithOneBomb, .TwoWithOneBomb, .Three, .One, .Chain]
        
        let spawnRandomAsteroid = SKAction.runBlock({self.creatPlanets()})
        let waitTime = SKAction.waitForDuration(2.0)
        let timesequence = SKAction.sequence([spawnRandomAsteroid,waitTime])
        runAction(SKAction.repeatActionForever(timesequence), withKey: key_creat_planet)
    }
    
    func endGame(){
        isGameEnd = true
        removeActionForKey(key_creat_planet)
        clearEnemy()
        clearSlice()
        waveArr = []
    }
    
    func dead(){
        endGame()
        setGrayColor(earth)
        earth.removeActionForKey(key_rotate_earth)
        createTips("Game Over!")
        createReStar()
    }
    
    func pass(){
        endGame()
        createTips("Pass!")
        runAction(SKAction.waitForDuration(2))
        switchToNewGameWithTransition()
    }
    
    
    func switchToNewGameWithTransition(){
        let index = RandomInt(min: 0, max: 11)
        let delay = SKAction.waitForDuration(0.2)
        let transition = SKAction.runBlock({
            let scene = GameScene(size: self.size)
            self.view?.presentScene(scene, transition: transitions[index])
        })
        
        runAction(SKAction.sequence([delay,transition]), withKey: "transition")
        
    }
    
    func clearEnemy(){
        for i in 0..<activeEnemies.count{
            activeEnemies[i].removeFromParent()
        }
    }
  
    

    /*---------game logic end---------*/

    
    /*---------creat enemy---------*/
    
    
    
    func creatNextWave() -> SequenceType{
        let nextWave = SequenceType(rawValue: RandomInt(min: 0, max: 7))!
        //print(nextWave)
        return nextWave
    }
    
    func creatPlanets(){
        wave++
        
        let newWave = creatNextWave()
        waveArr.append(newWave)
        
        let type = waveArr[wave]
        
        switch type{
        case .OneNoBomb:
            createRandomEnemy(Bomb.noBomb)
            
        case .One:
            createRandomEnemy()
            
        case .TwoWithOneBomb:
            createRandomEnemy(Bomb.noBomb)
            createRandomEnemy(Bomb.mustBomb)
            
        case .Tow:
            creatMultipleEnemies(2)
            
        case .Three:
            creatMultipleEnemies(3)
            
        case .Four:
            creatMultipleEnemies(4)
            
        case .Chain:
            createRandomEnemy()
            creatMultipleEnemies(4,delay: Int(chainDelay/5.0))
            
        case .Bomb:
            createRandomEnemy(Bomb.mustBomb)
            creatMultipleEnemies(2,delay: Int(chainDelay/2.0),bomb: Bomb.mustBomb)
            
        case .FastChain:
            createRandomEnemy()
            creatMultipleEnemies(4,delay: Int(chainDelay/10.0))
        }
    }
    
    
    func randomEnemyType(bomb:Bomb = .random) -> Int{
        var enemyType:Int = 0
        if bomb == Bomb.mustBomb {
            enemyType = 0
        } else if bomb == Bomb.noBomb {
            enemyType = RandomInt(min: 1, max: 3)
        } else {
            enemyType = RandomInt(min: 0, max: 3)
        }
        return enemyType
    }
    
    
    func creatMultipleEnemies(loop:Int,delay:Int = 0,bomb:Bomb = .random){

        for(var i = 0;i<loop;i++){
            RunAfterDelay(NSTimeInterval(delay*i),block:{
                self.createRandomEnemy(bomb)
            })
        }
    }
    
    
    func createRandomEnemy(bomb:Bomb = .random){
        let enemyType = randomEnemyType(bomb)
        let imageStr = switchImageString(enemyType)
        let enemy = Enemy(enemyImageStr: imageStr)
        enemy.setupMovement(64, max: 960)
        addChild(enemy)
        activeEnemies.append(enemy)
    }
    
    
    
    func switchImageString(type:Int) -> String{
        var imageStr = ""
        switch type {
        case 0:
            imageStr = image_bomb
            break
        case 1:
            imageStr = image_saturn
            break
        case 2:
            imageStr = image_murcury
            break
        case 3:
            imageStr = image_varnus
            break
        default:
            imageStr = image_bomb
            break
        }
        return imageStr
    }
    

    
    func alwaysBomb(){
        waveArr = []
        wave = 0
        for _ in 0 ... 1000 {
            let nextSequence = SequenceType(rawValue: 8)!
            waveArr.append(nextSequence)
            
        }

    }

    /*---------creat enemy end---------*/
    
    
    /*--------- touch event---------*/
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let touch = touches.first as UITouch!
        let location = touch.locationInNode(self)
        let node = nodeAtPoint(location)
        //print(location)
        clickButton(node)
        startSlice(location)
    }
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        
        let startPoint = touch.locationInNode(self)
        let endPoint = touch.previousLocationInNode(self)
        
        
        activeSlicePoints.append(startPoint)
        drawSlice()
        
        scene?.physicsWorld.enumerateBodiesAlongRayStart(startPoint, end: endPoint, usingBlock: {
            (body,point,normal,stop) -> Void in
            self.checkCut(body)
        })
        


    }
    


    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        clearSlice()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        clearSlice()
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(!isGameEnd){
            if activeEnemies.count > 0 {
                for node in activeEnemies {
                    if node.position.y < -80{
                        node.removeFromParent()
                        node.name = ""
                        if let index = activeEnemies.indexOf(node){
                            activeEnemies.removeAtIndex(index)
                        }
                    }
                }
            }
        }

    }
    
    
    /*--------- touch event end---------*/
    
    
    /*---------set prize & cut rope---------*/
    
    
    func setupPrizes(){
        for i in 0...1{
            let prize = Prize(pos: CGPointMake(self.width * 0.45, self.height * 1.2))
            addChild(prize)
            
            let enemy = prize as Enemy
            activeEnemies.append(enemy)
            prize.setupRopeSegments(self, index: i, width: width, height: height)
        }
    }
    
    
    /*---------set prize & cut rope end---------*/

    
    /*---------click button---------*/
    
    func clickButton(node:SKNode){
        
        if(node is SKLabelNode){
            if node.name == name_btn_restart{
                switchToNewGameWithTransition()
            }
//            if node.name == name_btn_back{
//                switchToNewGameWithTransition()
//            }
        }
    }
    
    /*---------click button end ---------*/
    /*---------slice---------*/
    
    
    func createSlices(){
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = Zposition.slice
        
        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = Zposition.slice
        
        activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        activeSliceBG.lineWidth = 9
        
        activeSliceFG.strokeColor = UIColor.whiteColor()
        activeSliceFG.lineWidth = 5
        
        addChild(activeSliceBG)
        addChild(activeSliceFG)
    }
    
    func startSlice(location:CGPoint){
        if(!isGameEnd){
            activeSlicePoints.removeAll(keepCapacity: true)
            activeSliceBG.removeAllActions()
            activeSliceFG.removeAllActions()
            activeSliceBG.alpha = 1
            activeSliceFG.alpha = 1
            activeSlicePoints.append(location)
            drawSlice()
            if !swooshSoundActive {
                playSwooshSound()
            }
        }
    }
    
    
    
    func playSwooshSound(){
        let randomNumber = RandomInt(min: 1, max: 3)
        let soundName = "swoosh\(randomNumber).caf"
        playSoundEffect(soundName)
    }
    
    
    func drawSlice(){
        if(!isGameEnd){
            if activeSlicePoints.count < 2 {
                activeSliceBG.path = nil
                activeSliceFG.path = nil
                return
            }
            
            while activeSlicePoints.count > 12 {
                activeSlicePoints.removeAtIndex(0)
            }
            
            let path = UIBezierPath()
            path.moveToPoint(activeSlicePoints[0])
            for var i = 1; i < activeSlicePoints.count; ++i {
                path.addLineToPoint(activeSlicePoints[i])
            }
            activeSliceBG.path = path.CGPath
            activeSliceFG.path = path.CGPath
        }
        
    }
    
    func clearSlice(){
        activeSliceFG.path = nil
        activeSliceBG.path = nil
    }
    
    
    
    
    
    func checkCut(body:SKPhysicsBody){
        if(!isGameEnd){
            let node = body.node
            if((node) != nil){
                let name:String = (node?.name)!
                print(name)
                if(name.characters.count>4){
                    let index = name.startIndex.advancedBy(4)
                    let subStr = name.substringToIndex(index)
                    if(subStr == name_rope){
                        node!.removeFromParent()
                        
                        self.enumerateChildNodesWithName(name, usingBlock: {
                            (node,stop) in
                            let rope = node as! Rope
                            rope.cut()
                        })
                    }
                }
                
                if(node is Enemy || node is Prize){
                    
                    let enemy = node as! Enemy
                    if(!enemy.isCut){
                        enemy.cut()
                        if enemy.name == name_enemy{
                            addScore(5)
                        }
                        
                        if enemy.name == name_bomb{
                            lostLife()
                        }
                        
                        if enemy.name == name_add_life{
                            addLife()
                        }
                        
                        let index = activeEnemies.indexOf(enemy)
                        if(index>0){
                            activeEnemies.removeAtIndex(index!)
                        }
                    }
                }
            }
        }

    }
    /*---------hit test---------*/
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        let contactBitMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if( contactBitMask == Category.earth  | Category.enemy ){
       
        }
    }


    
    /*---------hit test end---------*/

    
    /*---------slice end---------*/
    
    
    func playSoundEffect(name:String){
        runAction(SKAction.playSoundFileNamed(name, waitForCompletion: false))
    }

    
}
