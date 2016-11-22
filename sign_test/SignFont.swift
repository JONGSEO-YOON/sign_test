//
//  SignFont.swift
//  sign_test
//
//  Created by 윤종서 on 2016. 2. 26..
//  Copyright © 2016년 윤종서. All rights reserved.
//

import UIKit

class SignFont: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var FontTempImgae: UIImageView!
    @IBOutlet var FontImage: UIImageView!
    
    @IBOutlet var txfSignFont: UITextField!
    @IBOutlet var LabelSign: UILabel!
    

    @IBAction func btnSignFont(sender: AnyObject) {
        LabelSign.text = ""
    }
    
    var swiped = false
    var lastpoint = CGPoint.zero
    var img = UIImage(named: "IMG")
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
        
        // Setup the font specific variables
        var textColor: UIColor = UIColor.whiteColor()
        var textFont: UIFont = UIFont(name: "Helvetica Neue", size: 12)!
        
        //Setup the image context using the passed image.
        UIGraphicsBeginImageContext(inImage.size)
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        
        //Put the image into a rectangle as large as the original image.
        inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
        
        // Creating a point within the space that is as bit as the image.
        var rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)
        
        //Now Draw the text into an image.
        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return newImage
        
    }
    
    @IBAction func btnFontShare(sender: AnyObject) {
        FontImage.image = UIImage(named: "thisImage.png")
        //textToImage("000", inImage: FontImage.image.self!, atPoint: CGPointMake(20, 20))
        
        FontTempImgae.image = UIImage.imageWithLabel(LabelSign)
        
        
        //
        UIGraphicsBeginImageContext(FontImage.frame.size)
        FontImage.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        FontTempImgae.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        FontImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        FontTempImgae.image = nil
        
        ////////////////
        UIGraphicsBeginImageContext(FontImage.bounds.size)
        
        FontImage.image?.drawInRect(CGRect(x: 0, y: 0,
            width: FontImage.frame.size.width, height: FontImage.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let imagePNG = UIImagePNGRepresentation(image)
        UIGraphicsEndImageContext()
        
        let act = UIActivityViewController(activityItems: [imagePNG!], applicationActivities: nil)
        presentViewController(act, animated: true, completion: nil)
        //
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txfSignFont.delegate = self
        
        
        LabelSign.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        //LabelSign.transform = CGAffineTransformMakeScale(2, 2)
        //FontTempImgae.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI_2)) / 180.0)
        //FontImage.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI_2)) / 180.0)

        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        
        return true
    }
    func textFieldDidEndEditing(textField: UITextField)
    {
        LabelSign.text = txfSignFont.text
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first as UITouch! {
            lastpoint = touch.locationInView(self.view)
        }
    }
}

extension UIImage {
    class func imageWithLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}