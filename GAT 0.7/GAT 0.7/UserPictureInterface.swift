//
//  DataUplaoding.swift
//  GAT 0.7
//
//  Created by ndrzhr on 8/14/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts
import MobileCoreServices

class UserPictureInterface: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var collectionViewUser:UICollectionView!;
    var images:[UIImage] = [UIImage]();
    var btnAdd: UIButton!;
    let btnAddImage = UIImage(named: "btnAdd");
    var imageCell: UIImage?;
    var imageViewCell:UIImageView?;
    var point:CGPoint!;
    var size:CGSize!;
    var cameraController: UIImagePickerController?;
    var albumController: UIImagePickerController?;

    
    convenience init(images:[UIImage]){
        self.init();
        self.images = images;
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        point = CGPoint(x: 0, y: 0);
        size = CGSize(width: view.bounds.width/2 - 22 , height: view.bounds.height / 3 - 15);
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 40, right: 10);
        layout.itemSize = size;
        collectionViewUser = UICollectionView(frame: view.frame, collectionViewLayout: layout);
        collectionViewUser.dataSource = self;
        collectionViewUser.delegate = self;
        collectionViewUser.registerClass(UserInterfaceCollectionViewCell.self, forCellWithReuseIdentifier: "Cell01");
        view.backgroundColor = UIColor.lightGrayColor();
        println("\(images.count)")
        view.addSubview(collectionViewUser)

        
        
        
        
    }
    override func viewDidAppear(animated: Bool) {
        var alert = UIAlertController(title: "---", message: "save or keep picking picturs?", preferredStyle: UIAlertControllerStyle.ActionSheet);
        var actionCamera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            if self.isCameraAvialable(){
                self.cameraController = UIImagePickerController();
                if let theController = self.cameraController{
                    theController.sourceType = UIImagePickerControllerSourceType.Camera;
                    theController.mediaTypes = [kUTTypeImage as String];
                    theController.allowsEditing = true;
                    theController.delegate = self;
                    theController.showsCameraControls = true;
                    self.presentViewController(theController, animated: animated, completion: nil);
                    
                }
            }
                    }
        
        var actionAlbum = UIAlertAction(title: "Album", style: UIAlertActionStyle.Default, handler: nil);
        var actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: nil);
        alert.addAction(actionCamera);
        alert.addAction(actionAlbum);
        alert.addAction(actionCancel);
        presentViewController(alert, animated: true, completion: nil);
    }
    func btnAddPressed(){
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell01", forIndexPath: indexPath)as! UserInterfaceCollectionViewCell;
        
        cell.imageView.image = images[indexPath.row];
        return cell;
    }
    func isCameraAvialable()-> Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera);
    }
    func isAlbumAvialable()->Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary);
    }

    
    func showCamera(animated:Bool) -> UIImagePickerController {
        if self.isCameraAvialable(){
            self.cameraController = UIImagePickerController();
            if let theController = self.cameraController{
                theController.sourceType = UIImagePickerControllerSourceType.Camera;
                theController.mediaTypes = [kUTTypeImage as String];
                theController.allowsEditing = true;
                theController.delegate = self;
                theController.showsCameraControls = true;
                self.presentViewController(theController, animated: animated, completion: nil);
                
            }
        }
        return self.cameraController!;
    }
    func showAlbum(){
        if self.isAlbumAvialable(){
            self.albumController = UIImagePickerController();
            if let theController = self.albumController{
                theController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                theController.mediaTypes = [kUTTypeImage as String];
                theController.allowsEditing = true;
                theController.delegate = self;
                self.presentViewController(theController, animated: true, completion: nil);
            }
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

        images.append(image);
        reloadInputViews();
        // ****
        
        
    }
}
