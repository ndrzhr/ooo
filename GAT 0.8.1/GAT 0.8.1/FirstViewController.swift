//
//  FirstViewController.swift
//  GAT 0.8.1
//
//  Created by ndrzhr on 9/2/15.
//  Copyright © 2015 ndrzhr. All rights reserved.
//

import UIKit

import Parse
import Bolts


class FirstViewController: UIViewController  {
    
    var isLoaded:Bool = false;
    var Query = PFQuery(className: "userPhoto");
    var objectsRetrivedFromServer = [AnyObject]();
   // var feed:CollectionViewFeed?;
    let locationManager = CLLocationManager();
    var objects = [AnyObject]();
    var feed:CollectionViewFeed?;


    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil{
                self.objectsRetrivedFromServer = objects!;
                self.isLoaded = true;
                print(self.isLoaded)
               self.feed = CollectionViewFeed(objects: self.objectsRetrivedFromServer);
                
                self.presentViewController(self.feed!, animated: true, completion: nil);
                
            }else{
                print(error)
            }
        };

    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of objects retrived from server: \(objectsRetrivedFromServer.count)");
        //return objectsRetrivedFromServer.count;
        return 4;
        
    }
    

    
    
    

}

