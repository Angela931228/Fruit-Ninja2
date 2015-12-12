//
//  GameViewController.swift
//  Fruit
//
//  Created by 戢婧祎 on 28/11/15.
//  Copyright (c) 2015年 戢婧祎. All rights reserved.
//

import UIKit
import SpriteKit
import Toucan
class GameViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

<<<<<<< HEAD
       // UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
        if let scene = DirectorScene(fileNamed:"DirectorScene") {
=======
        if let scene = MenuScene(fileNamed:"MenuScene") {
>>>>>>> 8797522ba6fd4517b0a1f11bb63d0108d9481dba
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            NSNotificationCenter.defaultCenter().addObserver(self, selector:"showPopView", name: "chooseImageFromPhotoLibrary", object: nil)
            skView.presentScene(scene)
        }
    }
    
    func showPopView(){
        
        let picker = UIImagePickerController()
        picker.delegate = self;
        picker.sourceType =  .PhotoLibrary

        var popViewController = UIPopoverController(contentViewController: picker)
        popViewController.popoverContentSize = CGSizeMake(500, 600)
        popViewController.presentPopoverFromRect(CGRectMake(100, 100, 300, 400), inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
 
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // your code
        //imageView.image = info[UIImagePickerControllerOriginalImage] as UIImage
        //dismissViewControllerAnimated(true, completion: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizedAndMaskedImage = Toucan(image: selectedImage).resize(CGSize(width: 150, height: 150)).maskWithEllipse().image
        //imageView.image = selectedImage
        //imageView.image = resizedAndMaskedImage
        let imageData = UIImagePNGRepresentation(resizedAndMaskedImage)
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let imageURL = documentsURL.URLByAppendingPathComponent("cached.png")
        let urlString = imageURL.absoluteString
        NSLog(urlString)
        if !imageData!.writeToURL(imageURL, atomically: false)
        {
            print("not saved")
        } else {
            print("saved")
            NSUserDefaults.standardUserDefaults().setObject(urlString, forKey: "imagePath")
        }
        //imageView.image = loadImageFromPath(urlString)
    }
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        
        
        let filename = NSHomeDirectory() + "/Documents/" + "cached.png"
        let data = NSData(contentsOfFile: filename)
        let image1 = UIImage(data: data!)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image1
        
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
        return false
    }


    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
       /* if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }*/
        return .All
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    


    
    
}

