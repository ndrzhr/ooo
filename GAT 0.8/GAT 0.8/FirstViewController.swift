//
//  FirstViewController.swift
//  GAT 0.8
//
//  Created by ndrzhr on 8/30/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import Parse
import Bolts

class FirstViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionViewFeed: UICollectionView!
    var Query = PFQuery(className: "userPhoto");
    var objectsRetrivedFromServer = [AnyObject]();
    var isLoaded:Bool = false;



    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil{
                self.objectsRetrivedFromServer = objects!;
                self.isLoaded = true;
                println(self.isLoaded)
                //self.feed = CollectionViewFeed(objects: self.objectsRetrivedFromServer);
                
                //self.presentViewController(self.feed!, animated: true, completion: nil);
                self.collectionViewFeed.backgroundColor = .yellowColor();
                self.view.addSubview(self.collectionViewFeed);
                
            }else{
                println(error)
            }
        };
        
        

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectsRetrivedFromServer.count;

    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)as! CollectionViewCell;
        var cellData = objectsRetrivedFromServer[indexPath.row] as! PFObject;
        let cellImageFile = cellData["imageFile"] as! PFFile;
        cellImageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
            if error == nil{
                if let imageData = data{
                    let image = UIImage(data: imageData);
                    cell.imageView.image = image;
                    
                }
            }
            
        }
        
        cell.textLabel.text = cellData.objectId;
        cell.textLabel.textColor = UIColor.whiteColor();
        return cell;
        

    }

}

