//
//  ViewController.swift
//  GPSTracker 1.3
//
//  Created by ndrzhr on 6/21/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
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
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

