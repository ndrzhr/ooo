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
    
    var numberOfCells: Int!;
    var objectIdArray:[String]!;
    //var imageviews:[UIImage]!;
    
    var collectionView: UICollectionView!;
    
    var point: CGPoint!;
    var size: CGSize!;

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var query = PFQuery(className: "userPhoto");
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil{
                self.numberOfCells = objects!.count;
                
                println("Seccessfully retrieved \(self.numberOfCells) ");
                if let objects = objects as? [PFObject]{
                    for object in objects{
                        println(object.objectId);
                        //self.objectIdArray?.append(object.objectId!);
                        //self.objectIdArray = self.objectIdArray;
                       // let userImageFile = object["imageFile"] as! PFFile
                        // userImageFile.getDataInBackgroundWithBlock {
                        // (imageData: NSData?, error: NSError?) -> Void in
                        //  if error == nil {
                        //     if let imageData = imageData {
                        //        let image = UIImage(data:imageData);
                        //       self.imageViews!.append(image!);
                        
                        //   }
                        // }
                        // };
                        
                    }
                    
                    // feedCollectionView.imageviews = self.imageViews ;
                }
            }
        };

        
        
        ////---------
        
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
        var cellView = UIView(frame: CGRect(origin:point, size: size))
        cellView.backgroundColor = UIColor.whiteColor();
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell;
        var lableCell = UILabel(frame: CGRect(x: 0, y: size.height - 20, width: size.width, height: 20));
        lableCell.text = objectIdArray?[indexPath.row]
        lableCell.backgroundColor = UIColor.whiteColor();
        var imageViewCell = UIImageView(frame: CGRect(x: 0, y: 0, width: cellView.bounds.width, height: cellView.bounds.height - lableCell.bounds.height))
       // imageViewCell.image = imageviews[indexPath.row];
        cellView.addSubview(imageViewCell);
        cellView.addSubview(lableCell);
        cell.addSubview(cellView);
        return cell;
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells!;
    }
}
