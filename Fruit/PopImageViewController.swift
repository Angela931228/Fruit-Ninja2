//
//  PopImageViewController.swift
//  Fruit
//
//  Created by Angela on 12/12/15.
//  Copyright © 2015年 戢婧祎. All rights reserved.
//

import UIKit
import Toucan
class PopImageViewController: UIViewController,  UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("TEST")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
@IBAction func chooseImageFromPhotoLibrary(){
        let picker = UIImagePickerController()
        picker.delegate = self;
        picker.sourceType =  .PhotoLibrary
        presentViewController(picker,animated:true,completion:nil)
    }
@IBAction func chooseImageFromCamera(){
        let imagePicker = UIImagePickerController()
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                NSLog("Application cannot access the camera.")
            }
        } else {
            NSLog("Application cannot access the camera.")
        }
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // your code
        //imageView.image = info[UIImagePickerControllerOriginalImage] as UIImage
        //dismissViewControllerAnimated(true, completion: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizedAndMaskedImage = Toucan(image: selectedImage).maskWithEllipse().image
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
        imageView.image = loadImageFromPath(urlString)
    }
    
    
}
