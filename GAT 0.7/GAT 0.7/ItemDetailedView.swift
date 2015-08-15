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
    
    convenience init(object: PFObject){
        self.init();
        self.object = object;
    }
        override func viewDidLoad() {
            view.backgroundColor = UIColor.whiteColor();
            
            println(object)
            let imageFile = object!["imageFile"] as! PFFile;
            imageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if error == nil{
                    if let imageData = data{
                         self.imageOne = UIImage(data: imageData);
                        self.imageView = UIImageView(frame: CGRect(x: 0, y: 25, width: self.view.bounds.width, height: 375));
                        
                        
                        self.imageView.image = self.imageOne!;
                        self.view.addSubview(self.imageView)
                    }
                }else{
                    println(error)
                }
                var scrolingView = UITableView(frame: CGRect(x: 0, y: 400, width: self.view.bounds.width, height: 2000));
                self.str =  (self.object!["imageName"] as! String);
                var lable:UILabel = UILabel(frame: CGRect(x: 0, y: 400, width: scrolingView.bounds.width, height: 40));
                lable.text = self.str;
                scrolingView.addSubview(lable);
                scrolingView.backgroundColor = UIColor.grayColor();
                self.view.addSubview(scrolingView);
            }
    }
}
/*
var cellData = objects[indexPath.row] as! PFObject;
let cellImageFile = cellData["imageFile"] as! PFFile;
cellImageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
if error == nil{
if let imageData = data{
let image = UIImage(data: imageData);
cell.imageView.image = image;

}
}
}
*/
