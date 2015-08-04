//
//  CollectionViewController.swift
//  AccessingPictureAlbum
//
//  Created by ndrzhr on 8/4/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation
import UIKit
import Parse

class FeedCollectionViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var objectIdArray = [String]();

    var imageviews:[UIImage]!;
    
    var collectionView: UICollectionView!;
    
    var imageTest: UIImage?;
    var point: CGPoint!;
    var size: CGSize!;

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var query = PFQuery(className: "userPhoto");
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error: NSError?) -> Void in
            if error == nil{
                if let objects = objects as? [PFObject]{
                    for object in objects {
                        self.objectIdArray.append(object.objectId!);
                        println("**\(self.objectIdArray.count)");

  
                    }
                }
            }
        }
        
        
        //println(objectIdArray[1]);
        point = CGPoint(x: 0, y: 0)
        size = CGSize(width: view.bounds.width/2 - 22 , height: view.bounds.height / 3);
        var cellFrame = CGRect(origin: point, size: size);
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 122, left: 10, bottom: 40, right: 10);
        layout.itemSize = size ;
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout);
        collectionView.center = view.center;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell");
        collectionView.backgroundColor = UIColor.lightGrayColor();
        self.view.addSubview(collectionView);
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell;
        
        
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        var cellView = UIView(frame: CGRect(origin:self.point, size: self.size))
        cellView.backgroundColor = UIColor.whiteColor();
        
        var lableCell = UILabel(frame: CGRect(x: 0, y: self.size.height - 20, width: self.size.width, height: 20));
        //println("\(self.objectIdArray.count)")
        //lableCell.text = self.objectIdArray[indexPath.row + 1]
        
        lableCell.backgroundColor = UIColor.whiteColor();
        var imageViewCell = UIImageView(frame: CGRect(x: 0, y: 0, width: cellView.bounds.width, height: cellView.bounds.height - lableCell.bounds.height))
        //imageViewCell.image = self.imageviews[indexPath.row + 1];
       // imageViewCell.image = self.imageTest;
        cellView.addSubview(imageViewCell);
        cellView.addSubview(lableCell);
        cell.addSubview(cellView);
      });
     
        
       
        return cell;
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var query = PFQuery(className: "userPhoto");
        var number = query.findObjects()!.count as Int;
        return number;
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("item: \(indexPath.item)")
        println("row: \(indexPath.row)")

    }
}
/*
if error == nil && blabla != nil{
let userImageFile = blabla?["imageFile"] as! PFFile
userImageFile.getDataInBackgroundWithBlock {
(imageData: NSData?, error: NSError?) -> Void in
if error == nil {
if let imageData = imageData {
let image = UIImage(data:imageData);
//self.imageviews.append(image!);
self.imageTest = image;

}
}
};
}else{
println(error);
}

*/