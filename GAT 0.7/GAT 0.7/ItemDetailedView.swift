//
//  ItemDetailedView.swift
//  GAT 0.7
//
//  Created by ndrzhr on 8/15/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class ItemDetailedView: UIViewController,UINavigationControllerDelegate {
    
    var object:PFObject?;
    var imageView: UIImageView!;
    var imageOne:UIImage?;
    var str:String?;
    var btnBack: UIButton!;
    
    
    
    
    convenience init(object: PFObject){
        self.init();
        self.object = object;
    }
    override func viewDidLoad() {
        
        btnBack = UIButton(frame: CGRect(x: view.bounds.width/2 - 35, y: view.bounds.height - 100, width: 70, height: 70));
        btnBack.setImage(UIImage(named: "closeIcon"), forState: UIControlState.Normal);
        btnBack.addTarget(self, action: "btnBackPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        view.addSubview(btnBack);
        view.backgroundColor = UIColor.whiteColor();
        
        println(object)
        let imageFile = object!["imageFile"] as! PFFile;
        imageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
            if error == nil{
                if let imageData = data{
                    self.imageOne = UIImage(data: imageData);
                    self.imageView = UIImageView(frame: CGRect(x: 10, y: 20, width: self.view.bounds.width - 18, height: 375));
                    
                    
                    self.imageView.image = self.imageOne!;
                    self.view.addSubview(self.imageView)
                }else{
                    self.imageView.image = UIImage(named: "chair-512");
                }
            }else{
                println(error)
            }
            
            var lable:UILabel = UILabel(frame: CGRect(x: 10, y: 400, width: self.view.bounds.width, height: 40));
            
            lable.text = self.object!["objectId"] as? String;
            
            self.view.addSubview(lable);
        }
    }
    
    func btnBackPressed(sender: UIButton){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}

