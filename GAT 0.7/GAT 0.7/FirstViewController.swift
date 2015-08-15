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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
        Query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil{
                self.objectsRetrivedFromServer = objects!;
                self.isLoaded = true;
                println(self.isLoaded)
                self.feed = CollectionViewFeed(objects: self.objectsRetrivedFromServer);
                self.presentViewController(self.feed!, animated: true, completion: nil);
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
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarkers, error) -> Void in
            if(error != nil){
                println("Error: " + error.localizedDescription);
                return
            }
            if placemarkers.count > 0{
                let pm = placemarkers[0] as! CLPlacemark;
                self.displayLocationInfo(pm);
            }else{
                println("Error with data")
            }
        });
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
        self.locationManager.stopUpdatingLocation();
        println(placemark.locality);
        println(placemark.postalCode);
        println(placemark.administrativeArea);
        println(placemark.country);
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }

}

