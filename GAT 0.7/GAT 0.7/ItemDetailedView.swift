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
    var itemPictureView:UIView = UIView();
    var itemMainDetailView = UIScrollView();
    var itemFirstDetailedView = UIView();
    var itemSecondDetailedView = UIView();
    var btnContactMe:UIButton!;
    var itemNamelabel:UILabel!;
    
    var btnLike:UIButton!;
    var btnSendMessage:UIButton!;
    
    
    
    
    convenience init(object: PFObject){
        self.init();
        self.object = object;
    }
    override func viewDidLoad() {
        view.backgroundColor = .whiteColor();
        var itemPictureViewHeight = (self.view.bounds.height/20)*12;
        var itemPictureViewWidth = self.view.bounds.width
        
        
        
        itemPictureView.frame = CGRectMake(0, 20, itemPictureViewWidth,itemPictureViewHeight );
        itemPictureView.backgroundColor = .whiteColor();
        itemPictureView.layer.cornerRadius = 5;
        
        itemMainDetailView.frame = CGRectMake(0,itemPictureViewHeight, view.bounds.width, 800);
        itemMainDetailView.backgroundColor = .lightGrayColor();
        
        itemFirstDetailedView.frame = CGRectMake(0, 0, self.view.bounds.width, 50);
        itemFirstDetailedView.backgroundColor = .whiteColor();
        itemFirstDetailedView.layer.cornerRadius = 5;
        
        itemSecondDetailedView.frame = CGRectMake(0, 55, itemMainDetailView.bounds.width, 100);
        itemSecondDetailedView.backgroundColor = .whiteColor();
        itemSecondDetailedView.layer.cornerRadius = 5;
        
        btnContactMe = UIButton(frame: CGRect(x: 5, y: 55, width: itemSecondDetailedView.bounds.width - 10, height: 40));
        btnContactMe.setTitle("contact me", forState: UIControlState.Normal);
        btnContactMe.layer.cornerRadius = 5;
        btnContactMe.backgroundColor = UIColor(red: 0.01, green: 0.41, blue: 0.22, alpha: 1.0)
        
            

        
        itemNamelabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30));
        
        btnLike = UIButton(frame: CGRect(x: 240, y: 5, width: 60, height: 40));
        btnLike.setImage(UIImage(named: "haertIcon"), forState: UIControlState.Normal);
        
        btnSendMessage = UIButton(frame: CGRect(x: 310, y: 5, width: 60, height: 40));
        btnSendMessage.setImage(UIImage(named: "sendMessage"), forState: UIControlState.Normal);
        
        itemFirstDetailedView.addSubview(btnSendMessage);
        itemFirstDetailedView.addSubview(btnLike);
        itemFirstDetailedView.addSubview(itemNamelabel);
        
        
        
        
        
        
        btnBack = UIButton(frame: CGRect(x: view.bounds.width/2 - 35, y: view.bounds.height - 120, width: 70, height: 70));
        btnBack.setImage(UIImage(named: "closeIcon"), forState: UIControlState.Normal);
        btnBack.addTarget(self, action: "btnBackPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        itemSecondDetailedView.addSubview(btnContactMe);
        itemMainDetailView.addSubview(itemSecondDetailedView);
        itemMainDetailView.addSubview(itemFirstDetailedView);
        view.addSubview(itemPictureView);
        view.addSubview(itemMainDetailView);
        
        println(object)
        let imageFile = object!["imageFile"] as! PFFile;
        imageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
            if error == nil{
                if let imageData = data{
                    self.imageOne = UIImage(data: imageData);
                    self.imageView = UIImageView(frame: CGRect(x:0, y: 0, width: self.itemPictureView.bounds.width, height:itemPictureViewHeight - 20));
                    
                    
                    self.imageView.image = self.imageOne!;
                    self.itemPictureView.addSubview(self.imageView)
                }else{
                    self.imageView.image = UIImage(named: "chair-512");
                }
            }else{
                println(error)
            }
            if let object = self.object{
                
                self.itemNamelabel.text =  object.objectId;
                self.itemNamelabel.textColor = .grayColor();

            }
            
                    }
    }
    
    func btnBackPressed(sender: UIButton){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    override func viewDidAppear(animated: Bool) {
        view.addSubview(btnBack);

    }
}

