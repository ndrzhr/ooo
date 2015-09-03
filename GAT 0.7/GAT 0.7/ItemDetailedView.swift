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
    var itemConditionLabel:UILabel!;
    var itemStoryView:UIView!;
    
    var itemConditionIconView:UIImageView!;
    var conditionIconImage:UIImage = UIImage(named: "conditionIcon")!;
    var userImageView:UIImageView!;
    var userNameLabel:UILabel!;
    
    var btnLike:UIButton!;
    var btnSendMessage:UIButton!;
    
    var panGestureRecognizer: UIPanGestureRecognizer!;
    
    
    
    convenience init(object: PFObject){
        self.init();
        self.object = object;
    }
    override func viewDidLoad() {
        
        itemMainDetailView.showsVerticalScrollIndicator = true;
        itemMainDetailView.showsHorizontalScrollIndicator = true;
        itemMainDetailView.panGestureRecognizer.locationInView(view);
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "gesture:");
        panGestureRecognizer.minimumNumberOfTouches = 1;
        panGestureRecognizer.maximumNumberOfTouches = 1;
        view.addGestureRecognizer(panGestureRecognizer);
        
        view.backgroundColor = .whiteColor();
        let itemPictureViewHeight = (self.view.bounds.height/20)*12;
        let itemPictureViewWidth = self.view.bounds.width
        
        
        
        
        itemPictureView.frame = CGRectMake(0, 20, itemPictureViewWidth,itemPictureViewHeight );
        //itemPictureView.backgroundColor = .whiteColor();
        itemPictureView.layer.cornerRadius = 5;
        
        
        
        itemMainDetailView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1000));
        itemMainDetailView.backgroundColor = .lightGrayColor();
        
        itemFirstDetailedView.frame = CGRectMake(0, itemPictureView.frame.height, self.view.bounds.width, 50);
        itemFirstDetailedView.backgroundColor = .whiteColor();
        itemFirstDetailedView.layer.cornerRadius = 5;
        
        
        
        itemSecondDetailedView.frame = CGRectMake(0,itemPictureView.frame.height + 55, itemMainDetailView.bounds.width, 100);
        itemSecondDetailedView.backgroundColor = .whiteColor();
        itemSecondDetailedView.layer.cornerRadius = 5;
        
        btnContactMe = UIButton(frame: CGRect(x: 5, y: 55, width: itemSecondDetailedView.bounds.width - 10, height: 40));
        btnContactMe.setTitle("contact me", forState: UIControlState.Normal);
        btnContactMe.layer.cornerRadius = 5;
        btnContactMe.backgroundColor = UIColor(red: 0.01, green: 0.41, blue: 0.22, alpha: 1.0)
        
        userImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50));
        userImageView.image =  UIImage(named: "userImage");
        userImageView.layer.cornerRadius = 5;
        
        
        userNameLabel = UILabel(frame: CGRect(x: 55, y: 5, width: 150, height: 25));
        userNameLabel.font = UIFont.italicSystemFontOfSize(20);
        userNameLabel.text = "Israel Israeli";
        
        
        
        
        itemNamelabel = UILabel(frame: CGRect(x: 5, y: 0, width: 150, height: 22));
        
        itemConditionLabel = UILabel(frame: CGRect(x: 25, y: 28, width: 100, height: 22));
        itemConditionLabel.font = .italicSystemFontOfSize(15);
        
        itemConditionIconView = UIImageView(frame: CGRect(x: 5, y: 28, width: 18, height: 18));
        itemConditionIconView.image = conditionIconImage;
        if let object = self.object{
            
            
            itemNamelabel.text =  object.objectId;
            itemConditionLabel.text =  object.objectId;
            itemNamelabel.textColor = .grayColor();
            
        }
        
        
        btnLike = UIButton(frame: CGRect(x: 240, y: 5, width: 60, height: 40));
        btnLike.setImage(UIImage(named: "haertIcon"), forState: UIControlState.Normal);
        
        btnSendMessage = UIButton(frame: CGRect(x: 310, y: 5, width: 60, height: 40));
        btnSendMessage.setImage(UIImage(named: "sendMessage"), forState: UIControlState.Normal);
        
        
        itemStoryView = UIView(frame: CGRect(x: 0, y: 157, width: itemMainDetailView.bounds.width, height: 500));
        itemStoryView.backgroundColor = .whiteColor();
        itemStoryView.layer.cornerRadius = 5;
        
        
        
        
        itemFirstDetailedView.addSubview(itemConditionIconView);
        itemFirstDetailedView.addSubview(btnSendMessage);
        itemFirstDetailedView.addSubview(btnLike);
        itemFirstDetailedView.addSubview(itemNamelabel);
        itemFirstDetailedView.addSubview(itemConditionLabel);
        
        
        
        
        
        btnBack = UIButton(frame: CGRect(x: view.bounds.width/2 - 35, y: view.bounds.height - 80, width: 70, height: 70));
        btnBack.setImage(UIImage(named: "closeIcon"), forState: UIControlState.Normal);
        btnBack.addTarget(self, action: "btnBackPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        itemSecondDetailedView.addSubview(userNameLabel);
        itemSecondDetailedView.addSubview(userImageView);
        itemSecondDetailedView.addSubview(btnContactMe);
        
        
        //itemMainDetailView = UIScrollView(frame: CGRect(x: 0, y: itemPictureView.bounds.height, width: self.view.bounds.width, height: 1500));
        itemMainDetailView.pagingEnabled = true;
        itemMainDetailView.contentSize = CGSizeMake(self.view.bounds.width, 1500);
        
        
        itemMainDetailView.addSubview(itemStoryView);
        itemMainDetailView.addSubview(itemSecondDetailedView);
        itemMainDetailView.addSubview(itemFirstDetailedView);
        
        itemMainDetailView.addSubview(itemPictureView);
        view.addSubview(itemMainDetailView);
        
        print(object)
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
                print(error)
            }
            
        }
    }
    
    func btnBackPressed(sender: UIButton){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    override func viewDidAppear(animated: Bool) {
        view.addSubview(btnBack);
        
    }
    
    func gesture(sender: UIPanGestureRecognizer){
        
        print("location in view:\(sender.locationInView(view))")
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            if(sender.state != UIGestureRecognizerState.Ended && sender.state != UIGestureRecognizerState.Failed){
                //self.view.transform = CGRectMake(, <#y: CGFloat#>, <#width: CGFloat#>, <#height: CGFloat#>)
            }
        });
        
  
    }
    
}

