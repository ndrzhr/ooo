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
import CoreLocation

class FirstViewController: UIViewController , CLLocationManagerDelegate{
    
    var isLoaded:Bool = false;
    var Query = PFQuery(className: "userPhoto");
    var objectsRetrivedFromServer = [AnyObject]();
    var feed:CollectionViewFeed?;
    let locationManager = CLLocationManager();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
       // print("location: lat:\(locationManager.location.coordinate.latitude ) long: \(locationManager.location.coordinate.longitude )")
        
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
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation();
    }
  }

