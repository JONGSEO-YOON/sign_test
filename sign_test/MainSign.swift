

import UIKit
import Photos

class MainSign: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    @IBOutlet var SignImageView: [UIImageView]!
    
    var Temp = 2
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    ///Album
    
    var photosAsset: PHFetchResult!
    var collection: PHAssetCollection!
    var assetCollectionPlaceholder: PHObjectPlaceholder!
    
    //
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func btnRemove(sender: AnyObject) {
        
        if (Temp == 2)
        {
            SignImageView[11].image = nil
            Temp = 11
        }
        else if (Temp == 3)
        {
            SignImageView[2].image = nil
            Temp = 2
        }else if(Temp == 4){
            
            SignImageView[3].image = nil
            Temp = 3
        }else if(Temp == 5){
            
            SignImageView[4].image = nil
            Temp = 4
        }else if(Temp == 6){
            
            SignImageView[5].image = nil
            Temp = 5
        }else if(Temp == 7){
            
            SignImageView[6].image = nil
            Temp = 6
        }else if(Temp == 8){
            
            SignImageView[7].image = nil
            Temp = 7
        }else if(Temp == 9){
            
            SignImageView[8].image = nil
            Temp = 8
        }else if(Temp == 10){
            
            SignImageView[9].image = nil
            Temp = 9
        }else if(Temp == 11){
            
            SignImageView[10].image = nil
            Temp = 10
        }
        
        
        else if(Temp == 1)
        {
            Temp = 2
        }
        
        
    }
    @IBAction func reset(sender: AnyObject) {
       
        SignImageView[0].image = nil
        SignImageView[1].image = nil
        SignImageView[2].image = nil
        SignImageView[3].image = nil
        SignImageView[4].image = nil
        SignImageView[5].image = nil
        SignImageView[6].image = nil
        SignImageView[7].image = nil
        SignImageView[8].image = nil
        SignImageView[9].image = nil
        SignImageView[10].image = nil
        SignImageView[11].image = nil
        
        
        mainImageView.image = nil
        
        Temp = 2
    }
    
    @IBAction func share(sender: AnyObject) {
        
        // Merge tempImageView into mainImageView
        for (var i = 0; i < Temp; i++){
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        SignImageView[i].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        }
    ////////////////
        UIGraphicsBeginImageContext(mainImageView.bounds.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0,
            width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let imagePNG = UIImagePNGRepresentation(image)
        UIGraphicsEndImageContext()
        
        let act = UIActivityViewController(activityItems: [imagePNG!], applicationActivities: nil)
        presentViewController(act, animated: true, completion: nil)
    }



    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first as UITouch! {
            lastPoint = touch.locationInView(self.view)
        }
        
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        
        var i = 0
        i = Temp
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        SignImageView[i].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        // 3
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        // 4
        CGContextStrokePath(context)
        
        // 5
        SignImageView[i].image = UIGraphicsGetImageFromCurrentImageContext()
        SignImageView[i].alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 6
        swiped = true
        if let touch = touches.first as UITouch! {
            let currentPoint = touch.locationInView(view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        
        ////////////////2222222222222222222
        else if (Temp == 2)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[7].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[7].image = nil
            }
            ////////////////
            Temp = 3
        }
        ///////////////222222222222
        
        ////////////////3
        else if (Temp == 3)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[8].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[8].image = nil
            }
            ////////////////
            Temp = 4
        }
        ///////////////3
        
        ////////////////4
        else if (Temp == 4)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[9].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[9].image = nil
            }
            ////////////////
            Temp = 5
        }
        ///////////////4
        
        ////////////////5
        else if (Temp == 5)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[10].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[10].image = nil
            }
            ////////////////
            Temp = 6
        }
        ///////////////5
        
        ////////////////6
        else if (Temp == 6)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[11].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[11].image = nil
            }
            ////////////////
            Temp = 7
        }
        ///////////////6
        
        ////////////////7
        else if (Temp == 7)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[2].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[2].image = nil
            }
            ////////////////
            Temp = 8
        }
        ///////////////7
        
        ////////////////8
        else if (Temp == 8)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[3].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[3].image = nil
            }
            ////////////////
            Temp = 9
        }
        ///////////////8
        
        ////////////////9
        else if (Temp == 9)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[4].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[4].image = nil
            }
            ////////////////
            Temp = 10
        }
        ///////////////9
        
        ////////////////10
        else if (Temp == 10)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[5].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[5].image = nil
            }
            ////////////////
            Temp = 11
        }
        ///////////////10
        
        ////////////////11
        else if (Temp == 11)
        {
            for (var i = 0; i < 6; i++){
                UIGraphicsBeginImageContext(mainImageView.frame.size)
                mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
                SignImageView[6].image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
                mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                SignImageView[6].image = nil
            }
            ////////////////
            Temp = 2
        }
        ///////////////6
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let settingsViewController = segue.destinationViewController as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.brush = brushWidth
        settingsViewController.opacity = opacity
        settingsViewController.red = red
        settingsViewController.green = green
        settingsViewController.blue = blue
    }
    
}

extension MainSign: SettingsViewControllerDelegate {
    func settingsViewControllerFinished(settingsViewController: SettingsViewController) {
        self.brushWidth = settingsViewController.brush
        self.opacity = settingsViewController.opacity
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
    }
}


