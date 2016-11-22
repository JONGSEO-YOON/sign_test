//
//  SignScaleTouch.swift
//  sign_test
//
//  Created by 윤종서 on 2016. 2. 19..
//  Copyright © 2016년 윤종서. All rights reserved.
//
import UIKit
import Photos

class SignScaleTouch: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var location = CGPoint(x: 0, y: 0)
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var SwitchSignPhoto = false
    
    
    
    @IBOutlet var MainImageView: UIImageView!
    @IBOutlet var PhotoViewLarge: UIImageView!
    @IBOutlet var SignImageView: UIImageView!
    
    
    @IBAction func btnFinalShare(sender: AnyObject) {
        
        UIGraphicsBeginImageContext(MainImageView.frame.size)
        PhotoViewLarge.image?.drawInRect(CGRect(x: 0, y: 0, width: 375, height: 560), blendMode: CGBlendMode.Normal, alpha: 1.0)
        SignImageView.image?.drawInRect(CGRect(x: location.x - 25, y: location.y - 89, width: 50, height: 50), blendMode: CGBlendMode.Normal, alpha: opacity)
        PhotoViewLarge.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        SignImageView.image = nil
        
        ////////////////
        UIGraphicsBeginImageContext(PhotoViewLarge.bounds.size)
        PhotoViewLarge.image?.drawInRect(CGRect(x: 0, y: 0,
            width: 375, height: 560))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let imagePNG = UIImagePNGRepresentation(image)
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [imagePNG!], applicationActivities: nil)
        presentViewController(activity, animated: true, completion: nil)
        
    }
    @IBAction func btnSignView(sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
        
        SwitchSignPhoto = false
        
    }
    
    @IBAction func btnPhotoLibrary(sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
        
        SwitchSignPhoto = true
        
    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // @IBAction func TapGesturePhoto(sender: UITapGestureRecognizer) {
    
    
    // }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if(SwitchSignPhoto == true){
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            PhotoViewLarge.image = selectedImage
            dismissViewControllerAnimated(true, completion: nil)
        }else if(SwitchSignPhoto == false){
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            SignImageView.image = selectedImage
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch
        
        location = touch.locationInView(self.view)
        
        SignImageView.center = location
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var touch : UITouch! = touches.first! as UITouch
        
        location = touch.locationInView(self.view)
        
        SignImageView.center = location
    }
    
    
}
