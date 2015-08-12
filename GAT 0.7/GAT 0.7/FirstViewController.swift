//
//  FirstViewController.swift
//  GAT 0.7
//
//  Created by ndrzhr on 8/11/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import Parse
import Bolts

class FirstViewController: UIViewController {
    
    var isLoaded:Bool = false;
    var Query = PFQuery(className: "userPhoto");
    var objectsRetrivedFromServer = [AnyObject]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil{
                self.objectsRetrivedFromServer = objects!;
                self.isLoaded = true;
                println(self.isLoaded)
                var feed = CollectionViewFeed(objects: self.objectsRetrivedFromServer);
                self.presentViewController(feed, animated: true, completion: nil);
            }else{
                println(error)
            }
        };
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

