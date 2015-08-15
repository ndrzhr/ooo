//
//  CollectionViewFeed.swift
//  GAT 0.7
//
//  Created by ndrzhr on 8/11/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
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
    var userPictureInterface = UserPictureInterface();
    
    var images:[UIImage] = [UIImage]();
    

    
    convenience init(objects:[AnyObject]){
        self.init();
        self.objects = objects;
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();

        //----
        point = CGPoint(x: 0, y: 0);
        size = CGSize(width: view.bounds.width/2 - 22 , height: view.bounds.height / 3 - 15);
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 122, left: 10, bottom: 40, right: 10);
        layout.itemSize = size;
        //----
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout);
        //collectionView.center = view.center;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.registerClass(CollectionViewFeedCell.self, forCellWithReuseIdentifier: "Cell");
        collectionView.backgroundColor = UIColor.whiteColor();
        //-----
        btnAdd = UIButton(frame: CGRect(x: view.bounds.width / 2 - 35, y: view.bounds.height - 140, width: 70, height: 70));
        btnAdd.setImage(btnAddImage, forState: UIControlState.Normal);
        btnAdd.addTarget(self, action: "btnAddPressed", forControlEvents: UIControlEvents.TouchUpInside);
        
        
        view.addSubview(collectionView);
        view.addSubview(btnAdd);
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)as! CollectionViewFeedCell;
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
        
        cell.textLabel.text = cellData.objectId;
        cell.textLabel.textColor = UIColor.whiteColor();
        return cell;
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("You have selected item number \(indexPath.row) which is the object \(objects[indexPath.row])")
        var object = objects[indexPath.row] as! PFObject;
        let item = ItemDetailedView(object: object);

        self.presentViewController(item, animated: true, completion: nil);
       
        
        
    }
    func isCameraAvialable()-> Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera);
    }
    func isAlbumAvialable()->Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary);
    }
    func btnAddPressed(){
        var alert = UIAlertController(title: "Image Source", message: "Pleas Choose Image Source", preferredStyle: UIAlertControllerStyle.ActionSheet);
        
        var actionCam = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            var user = UserPictureInterface(camera: true, album: false);
            //self.showCamera(false);
            self.presentViewController(user, animated: false, completion: nil);
        };
        var actionAlbum = UIAlertAction(title: "Album", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            var user = UserPictureInterface(camera: false, album: true);
            //self.showAlbum();
            self.presentViewController(user, animated: false, completion: nil);
        };
        var actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: nil);
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
        userPictureInterface.images.append(image);
        self.presentViewController(userPictureInterface, animated: true, completion: nil);
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
