//
//  FirstViewController.swift
//  GAT 0.5
//
//  Created by ndrzhr on 8/5/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import Parse
import Bolts

class FirstViewController: UIViewController {
    var progressview : UIProgressView!;
    var Query = PFQuery(className: "userPhoto");
    var isFinishedDownlaodingFromServer = false;
    let btnImage = UIImage(named: "btn")
    var timer: NSTimer!;
    var lable: UITextView?;
    
    var btnQuery: UIButton!;

    override func viewDidLoad() {
        super.viewDidLoad()
        var objectsId = uploadQueryObjectsId();
        
        btnQuery = UIButton(frame: CGRect(x: view.center.x - 40, y: view.center.y - 100, width: 80, height: 80));
        btnQuery.setImage(btnImage, forState: UIControlState.Normal);
        btnQuery.addTarget(self, action: "btnQueryPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        
 
       
        
        progressview = UIProgressView(progressViewStyle: UIProgressViewStyle.Bar);
        progressview.progress = 0.01;
        progressview.backgroundColor = UIColor.lightGrayColor();
        progressview.tintColor = UIColor.blackColor();
        progressview.center = view.center;
        let timeInterval = 0.1;
        timer = NSTimer(timeInterval: timeInterval, target: self, selector: "checkAgain", userInfo: nil, repeats: true);
        
        if uploadQueryObjectsId().isEmpty{
            timer.fire()
        }
        lable = UITextView(frame: CGRect(x:0, y: 0, width: view.bounds.width, height: view.bounds.height));
        
        lable?.backgroundColor = UIColor.lightGrayColor();
        lable!.text = "Hi ..."
        view.addSubview(lable!);
        //view.addSubview(progressview)
        //view.addSubview(btnQuery);
        

       
}
    
    func checkAgain(){
       if uploadQueryObjectsId().isEmpty{
              println("checking ... ")
       }else{
        println("done")
        timer.invalidate()
        }
      
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnQueryPressed(sender: UIButton){
        if self.progressview != 1.0{
        self.progressview.progress = 0.0
        1
        uploadQueryObjectsId();
        }else{
            println("wait ... I'm loading" )
        }
    }
    
    func uploadQueryObjectsId() ->[NSString]{
        // to avoid a fault of "still in progress" ..
        Query.cancel()
        var objectIdArray:[NSString] = [NSString]();
        self.Query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil{
                println("seccessfully retrieved \(objects!.count) objects ")
                var prograssFull = Float(objects!.count);
                var counter = 0;
                var str = "";

                if let objects = objects as? [PFObject]{
                    for object in objects{
                        println(object.objectId!);
                        objectIdArray.append(object.objectId!);
                        self.progressview.progress += (1.0 / prograssFull);
                        self.lable!.text  = str;
                        str += "\(objectIdArray[counter]) \n;"
                        counter++;
                        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.value), 0), { () -> Void in
                            if !objectIdArray.isEmpty{
                            var image: UIImage? = self.getImage(object.objectId!)
                            
                            if var theImage = image {
                                    var imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100));
                                    imageview.image? = image!;
                                    self.view.addSubview(imageview);
                            }else {
                                println("object is empty")
                                }
                            }
                        });

                    }
                }
            }else{
                println(error);
            }
        }
        return objectIdArray;
    }
    
    
    func getImage(objectId:String) ->UIImage{
        var objectImage: UIImage!;
        println("888")
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 1), { () -> Void in
            self.Query.getObjectInBackgroundWithId(objectId, block: { (blabla: PFObject?, error:NSError?) -> Void in
                if error == nil && blabla != nil{
                    let userImageFile = blabla?["imageFile"] as! PFFile
                    userImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            if let imageData = imageData {
                                let image = UIImage(data:imageData);
                                objectImage = image!;
                                
                            }
                        }
                    };
                }
            })

        })
           return objectImage

    }


}

