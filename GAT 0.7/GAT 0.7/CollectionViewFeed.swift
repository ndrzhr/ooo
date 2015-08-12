//
//  CollectionViewFeed.swift
//  GAT 0.7
//
//  Created by ndrzhr on 8/11/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts


class CollectionViewFeed: UIViewController, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UINavigationControllerDelegate {
    
    var collectionView: UICollectionView!;
    var point: CGPoint!;
    var size: CGSize!;
    var btnCamera:UIButton!;
    let btnCameraImage = UIImage(named: "btnCameraImage")
    var objects = [AnyObject]();
    
   
    
    convenience init(objects:[AnyObject]){
        self.init();
        self.objects = objects;
    }



 
    override func viewDidLoad() {
        super.viewDidLoad();
        //----
        point = CGPoint(x: 0, y: 0);
        size = CGSize(width: view.bounds.width/2 - 22 , height: view.bounds.height / 3);
        //var cellFrame =
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 122, left: 10, bottom: 40, right: 10);
        layout.itemSize = size;
        //----
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout);
        //collectionView.center = view.center;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.registerClass(CollectionViewFeedCell.self, forCellWithReuseIdentifier: "Cell");
        //-----
        btnCamera = UIButton(frame: CGRect(x: view.bounds.width / 2 - 35, y: view.bounds.height - 140, width: 70, height: 70));
        btnCamera.setImage(btnCameraImage, forState: UIControlState.Normal);
        
        view.addSubview(collectionView);
        view.addSubview(btnCamera);
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)as! CollectionViewFeedCell;
        var cellData = objects[indexPath.row] as! PFObject;
        let cellImageFile = cellData["imageFile"] as! PFFile;
        cellImageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
            if error == nil{
                if let imageData = data{
                    let image = UIImage(data: imageData);
                    cell.imageView.image = image;
                    
                }
            }
        }
        
        //cell.textLabel.text = "indexpath.row \(indexPath.row)"
        cell.textLabel.text = cellData.objectId;
        //cell.imageView.image = UIImage(named: "btnCameraImage");
        cell.textLabel.textColor = UIColor.whiteColor();
        return cell;
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("You have selected item number \(indexPath.row) which is the object \(objects[indexPath.row])")
    }
    

}