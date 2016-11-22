//
//  CustomSignView.swift
//  sign_test
//
//  Created by 윤종서 on 2016. 2. 21..
//  Copyright © 2016년 윤종서. All rights reserved.   , UICollectionViewDelegate, UICollectionViewDataSource
//
/*
import UIKit

class CustomSignView: UICollectionViewController{
    
    
    var imagesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesArray = ["IMG_0015"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        
        
        
        var imageView = cell.viewWithTag(1) as! UIImageView
        
        
        imageView.image = UIImage(named: imagesArray[indexPath.row])
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath)

        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: 0, animations: ({
            cell?.frame = collectionView.bounds
            collectionView.scrollEnabled = false
            
        
        
        
        }), completion: nil)
    }
}
*/

import UIKit
class CustomSignView: UICollectionViewCell {
    
    @IBOutlet var MyLabel: UILabel!
    
}