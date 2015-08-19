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
import CoreLocation

class UserPictureInterface: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate,CLLocationManagerDelegate {
    
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
    var showCameraBool:Bool = false;
    var showAlbumeBool:Bool = false;
    
    var labels:[UILabel] = [UILabel]();
    
    var labelItemName: UILabel!;
    var labelItemDesc: UILabel!;
    var labelItemCat: UILabel!;
    var labelItemPlace: UILabel!;
    var labelItemCon: UILabel!;
    var labelsView: UIView!;
    let locationManager = CLLocationManager();
    
    
    convenience init(images:[UIImage]){
        self.init();
        self.images = images;
        
        
    }
    convenience init(camera:Bool,album:Bool){
        self.init();
        showCameraBool = camera;
        showAlbumeBool = album;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelsView = UIView(frame: CGRect(x: view.bounds.width / 2, y: 0, width: 0, height: 0));
        labelsView.backgroundColor = UIColor.whiteColor();
        
        self.labelItemName =  UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 20));
        self.labelItemDesc = UILabel(frame: CGRect(x: 0, y: 20, width: self.view.bounds.width, height: 20));
        self.labelItemCat = UILabel(frame: CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 20));
        self.labelItemPlace = UILabel(frame: CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 20));
        self.labelItemCon = UILabel(frame: CGRect(x: 0, y: 80, width: self.view.bounds.width, height: 20));
        labelItemName.text = "labelItemName: ";
        labelItemDesc.text = "labelItemDesc: ";
        labelItemCat.text = "labelItemCat: ";
        labelItemPlace.text = "labelItemPlace: ";
        labelItemCon.text = "labelItemCon: ";
        
        
        self.labelsView.addSubview(self.labelItemName);
        self.labelsView.addSubview(self.labelItemDesc);
        self.labelsView.addSubview(self.labelItemCat);
        self.labelsView.addSubview(self.labelItemPlace);
        self.labelsView.addSubview(self.labelItemCon);
        
        
        showCamera(false);
        
        labels.append(self.labelItemName);
        labels.append(self.labelItemDesc);
        labels.append(self.labelItemCat);
        labels.append(self.labelItemPlace);
        labels.append(self.labelItemCon);
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
        
        point = CGPoint(x: 0, y: 0);
        size = CGSize(width: view.bounds.width/2 - 22 , height: view.bounds.height / 3 - 40);
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
        
        if showCameraBool{
            self.showCamera(false);
        }else if showAlbumeBool{
            self.showAlbum();
            
        }else{
            
        }
        
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
        showCameraBool = false;
        showAlbumeBool = false;
        images.append(image);
        
        if images.count <= 3{
            dismissViewControllerAnimated(true, completion: { () -> Void in
                var alert = UIAlertController(title: "Add another Photo", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet);
                var actionCamera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
                    if self.isCameraAvialable(){
                        self.cameraController = UIImagePickerController();
                        if let theController = self.cameraController{
                            theController.sourceType = UIImagePickerControllerSourceType.Camera;
                            theController.mediaTypes = [kUTTypeImage as String];
                            theController.allowsEditing = true;
                            theController.delegate = self;
                            theController.showsCameraControls = true;
                            self.presentViewController(theController, animated: true, completion: nil);
                            
                        }
                    }
                }
                
                var actionAlbum = UIAlertAction(title: "Album", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                    self.showCameraBool = false;
                    self.showAlbumeBool = true;
                    self.showAlbum()
                });
                var actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: { (action: UIAlertAction!) -> Void in
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        println("dissmised from userInterfaceController")
                    });
                });
                var actionUplaod = UIAlertAction(title: "Save", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction!) -> Void in
                    var btnSave = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 35, y: self.view.bounds.height - 60, width: 70, height: 70));
                    btnSave.setImage(UIImage(named: "Upload"), forState: UIControlState.Normal)
                    btnSave.addTarget(self, action: "uploadToServer", forControlEvents: UIControlEvents.TouchUpInside);
                    self.view.addSubview(self.labelsView);
                    self.view.addSubview(btnSave);
                    self.collectionViewUser.backgroundColor = UIColor.whiteColor();
                 // lable animation:
                    UIView.animateWithDuration(2.0, animations: { () -> Void in
                
                        self.labelsView.frame = CGRectMake(10, 400, self.view.bounds.width - 18, 200);
                        
                        }, completion: {finished in
                            
                            
                            self.labelsView.frame = CGRectMake(10, 400, self.view.bounds.width - 18, 200);
                            
                            self.labelItemName.frame = CGRectMake(10, 400, self.view.bounds.width - 18, 20);
                            self.labelItemDesc.frame = CGRectMake(10, 420, self.view.bounds.width - 18, 20);
                            self.labelItemCat.frame = CGRectMake(10, 440, self.view.bounds.width - 18, 20);
                            self.labelItemPlace.frame = CGRectMake(10, 460, self.view.bounds.width - 18, 20);
                            self.labelItemCon.frame = CGRectMake(10, 480, self.view.bounds.width - 18, 20);
                            
                            self.labelsView.backgroundColor = UIColor.lightGrayColor();
                            println("done animation")
                            //self.labelsView.addSubview(self.labelItemName);
                            self.view.addSubview(self.labelItemName);
                            self.view.addSubview(self.labelItemDesc);
                            self.view.addSubview(self.labelItemCat);
                            self.view.addSubview(self.labelItemPlace);
                            self.view.addSubview(self.labelItemCon);
                            
                    });
                    
                    self.collectionViewUser.reloadData();
                })
                alert.addAction(actionCamera);
                alert.addAction(actionAlbum);
                alert.addAction(actionCancel);
                alert.addAction(actionUplaod);
                self.presentViewController(alert, animated: true, completion: nil);
                
            });
        }else{
            self.dismissViewControllerAnimated(true, completion: nil);
            var btnSave = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 35, y: self.view.bounds.height - 60, width: 70, height: 70));
            btnSave.setImage(UIImage(named: "Upload"), forState: UIControlState.Normal)
            btnSave.addTarget(self, action: "uploadToServer", forControlEvents: UIControlEvents.TouchUpInside);
            self.collectionViewUser.backgroundColor = UIColor.whiteColor();
            self.view.addSubview(btnSave);
            self.view.addSubview(self.labelsView)
            
            UIView.animateWithDuration(2.0, animations: { () -> Void in
                
                self.labelsView.frame = CGRectMake(10, 400, self.view.bounds.width - 18, 200);
                self.labelsView.backgroundColor = UIColor.redColor();
                
            });
            
            
            
            
            
            self.collectionViewUser.reloadData();
        }
        
        self.collectionViewUser.reloadData();
    }
    
    func uploadToServer(){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            println("Uplaoding to the server in the background...");
            var item = ItemDetails();
            item.itemName = "item name";
            item.itemDesc = "item Desc";
            item.itemCat = "itemCat";
            
            item.itemPlace = "lat: \(self.locationManager.location.coordinate.latitude) long: \(self.locationManager.location.coordinate) "
            
            for i  in 0..<self.images.count{
                var userPhoto = PFObject(className: "userPhoto");
                let imageData = UIImagePNGRepresentation(self.images[i]);
                let imageFile = PFFile(name: "image.png", data: imageData);
                userPhoto["imageName"] = item.itemName;
                userPhoto["imageFile"] = imageFile;
                
                userPhoto["itemLocation"] = "lat: \(self.locationManager.location.coordinate.latitude) long: \(self.locationManager.location.coordinate.longitude) "
                
                userPhoto.saveInBackground();
                
            }
            
            
        });
        self.collectionViewUser.dataSource = nil;
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(false, completion: nil);
        
        showAlbumeBool = false;
        showCameraBool = false;
        self.dismissViewControllerAnimated(true, completion: nil);
        self.collectionViewUser.dataSource = nil;
    }
    
}
