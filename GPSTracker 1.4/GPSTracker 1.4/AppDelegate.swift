//
//  AppDelegate.swift
//  GPSTracker 1.4
//
//  Created by ndrzhr on 6/22/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import CoreLocation

var lat: CLLocationDegrees!;
var lng: CLLocationDegrees!;
var loc: CLLocation!;

class Location{
    init(latitude: Double,longitude:Double){
        self.latitude = latitude;
        self.longitude = longitude;
    }
    var latitude: Double;
    var longitude: Double;
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate,NSURLSessionDataDelegate,NSURLSessionDelegate {

    var window: UIWindow?
    let user = UIDevice();
    var locationManager: CLLocationManager!;
    var isExecutingInBackground = false;
    private var _locationDelegate: LocationDelegate?;
    
    class func locationChangedNotification() ->String {
        return "\(__FUNCTION__)";
    }
    
    var locationDelegate:LocationDelegate?{
        get{
            return _locationDelegate;
        }
        set{
            _locationDelegate = newValue;
        }
    }
    
    //-------------
    
    var session: NSURLSession!;
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
    
    
    //--------------


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization();
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation();
        
        return true;
    }
    
    func locationManagerDidResumeLocationUpdates(manager: CLLocationManager!) {
        //sendLocation()
    }
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {

    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        session.finishTasksAndInvalidate();
        println("did complete. error  \(error)");
    }
    
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {/*
        println("did receive data ");
        
        println("on Thread: \(NSThread.currentThread())");
        
        var response = NSString(data: data, encoding: NSUTF8StringEncoding);
        if let theResponse = response{
            println(theResponse);
        }
        */
        
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        isExecutingInBackground = true;
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        isExecutingInBackground = false;
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
            }
    
    
    func sendData(){
        configuration.timeoutIntervalForRequest = 15.0;
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        println("location: lat: \(lat),' lng: \(lng)")
        var userBatterryLevel = user.batteryLevel;
        let model = user.model;
        let userName = user.name;
        var dataToUpload = "{'userName':'\(userName)'}".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
        let url = NSURL(string: "http://ndrzhr.selfip.com:8080/MainServlet");
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";
        let task = session.uploadTaskWithRequest(request, fromData: dataToUpload);
        task.resume();
    }
    
    func checkMessages(){
        configuration.timeoutIntervalForRequest = 15.0;
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        let url = NSURL(string: "http://ndrzhr.selfip.com:8080/MainServlet");
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";

        let dictionary : [String:AnyObject] = [
            "action" : "getLocation",
            "userName" : "user",
            "fromMessage" : 9,
            "messageText":"Text Text",
            "lat":"\(lat)",
            "lng":"\(lng)",
            "time":"\(loc.timestamp)"
        ];
        var error:NSError?;
        let data = NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted, error: &error);
        let task = session.uploadTaskWithRequest(request, fromData: data);
        task.resume();
        
    }

}

