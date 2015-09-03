//
//  CollectionViewFeed.swift
//  GAT 0.8.1
//
//  Created by ndrzhr on 9/2/15.
//  Copyright © 2015 ndrzhr. All rights reserved.
//


import Foundation
import UIKit
import Parse
import Bolts
import MobileCoreServices
import CoreLocation


class CollectionViewFeed: UIViewController, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate {
    
    var collectionView: UICollectionView!;
    var point: CGPoint!;
    var size: CGSize!;
    var btnAdd:UIButton!;
    let btnAddImage = UIImage(named: "btnAdd")
    let btnCameraImage = UIImage(named: "btnCameraImage");
    let btnAlbumImage = UIImage(named: "btnAlbumImage");
    var objects = [AnyObject]();
    var cameraController: UIImagePickerController?;
    var albumController: UIImagePickerController?;
    var btnOpenAlbum: UIButton?;
   // var userPictureInterface = UserPictureInterface();
    
    var images:[UIImage] = [UIImage]();
    
    
    
    convenience init(objects:[AnyObject]){
        self.init();
        self.objects = objects;
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
            }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)as! CollectionViewCell;
        let cellData = objects[indexPath.row] as! PFObject;
        let cellImageFile = cellData["imageFile"] as! PFFile;
        cellImageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
            if error == nil{
                if let imageData = data{
                    let image = UIImage(data: imageData);
                    cell.cellImageView.image = image;
                    
                }
            }
            
        }
        
        cell.cellLabel.text = cellData.objectId;
        cell.cellLabel.textColor = UIColor.whiteColor();
        return cell;
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("You have selected item number \(indexPath.row) which is the object \(objects[indexPath.row])")
        _ = objects[indexPath.row] as! PFObject;
        //let item = ItemDetailedView(object: object);
        
        //self.presentViewController(item, animated: true, completion: nil);
        
        
        
    }
    func isCameraAvialable()-> Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera);
    }
    func isAlbumAvialable()->Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary);
    }
    func btnAddPressed(){
        let alert = UIAlertController(title: "Image Source", message: "Pleas Choose Image Source", preferredStyle: UIAlertControllerStyle.ActionSheet);
        
        let actionCam = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            //let user = UserPictureInterface(camera: true, album: false);
            //self.showCamera(false);
           // self.presentViewController(user, animated: false, completion: nil);
        };
        let actionAlbum = UIAlertAction(title: "Album", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
           // let user = UserPictureInterface(camera: false, album: true);
            //self.showAlbum();
           // self.presentViewController(user, animated: false, completion: nil);
        };
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: nil);
        alert.addAction(actionCam);
        alert.addAction(actionAlbum);
        alert.addAction(actionCancel);
        presentViewController(alert, animated: true, completion: nil);
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        picker.allowsEditing = true;
        picker.delegate = self;
        dismissViewControllerAnimated(false, completion: { () -> Void in
            //self.showCamera(true);
            
        });
       // userPictureInterface.images.append(image);
        //self.presentViewController(userPictureInterface, animated: true, completion: nil);
    }
    
    func showCamera(animated:Bool){
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
}