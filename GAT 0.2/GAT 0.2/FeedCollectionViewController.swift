//
//  FeedCollectionViewController.swift
//  GAT 0.2
//
//  Created by ndrzhr on 8/1/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import MobileCoreServices

class FeedCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,UISearchBarDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    let btnImage: UIImage = UIImage(named: "redCamera")!;
    var btnAdd: UIButton!;
    var searchBar: UISearchBar!;
    var tableView: UITableView!
    var inView: UIViewController!;
    var cameraController: UIImagePickerController?;
    var picView: PictureView?;

    
//----------------------------------
    var tableData:[String] = ["monster-01","monster-02","monster-03","monster-04","monster-05","monster-06","monster-07","monster-08","monster-09","monster-10","monster-11","monster-12","monster-13","monster-14","monster-15","monster-16"];
    var tableImages:[String] = ["monsters-01","monsters-02","monsters-03","monsters-04","monsters-05","monsters-06","monsters-07","monsters-08","monsters-09","monsters-10","monsters-11","monsters-12","monsters-13","monsters-14","monsters-15","monsters-16"];
//-----------------------------------

    override func viewDidLoad() {
        super.viewDidLoad();
        
        collectionView?.backgroundColor = UIColor.lightGrayColor();
        
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80));
        searchBar.autocorrectionType = UITextAutocorrectionType.No;
        searchBar.delegate = self;
        searchBar.searchBarStyle = UISearchBarStyle.Minimal;
        
        searchBar.backgroundColor = UIColor.whiteColor();
        view.addSubview(searchBar);
               
        
        
        btnAdd = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton;
        btnAdd.frame = CGRect(x: view.center.x - 35, y: view.bounds.height - 110, width: 70, height: 70);
        btnAdd.setImage(btnImage, forState: UIControlState.Normal)
        btnAdd.addTarget(self, action: "btnCameraPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        view.addSubview(btnAdd)
        
        
   
    }
    

    
    

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true);
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = "";
        searchBar.setShowsCancelButton(false, animated: true);
        searchBar.resignFirstResponder();
    }

 
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell;
        cell.lableCell.text = tableData[indexPath.row];
        cell.backgroundColor = UIColor.whiteColor();
        cell.imageCell.image = UIImage(named: tableImages[indexPath.row]);
        //cell.frame = CGRect(x: 0, y: 0, width: 50, height: 50);
        return cell;
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell \(indexPath.row) selected")
    }
    
    
    //------ camera -----
    
    
    func isCameraAvialable()-> Bool{
        return  UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera);
    }
    
    
    func btnCameraPressed(sender: UIButton){
        println("***++++")
      //  let cameraView = CameraViewController();
       // self.presentViewController(cameraView, animated: true, completion: nil);
        
        //picView = PictureView();
        //presentViewController(picView!, animated: false, completion: nil);
        cameraController = UIImagePickerController();
        
        if let theController = cameraController{
            theController.sourceType = UIImagePickerControllerSourceType.Camera;
            theController.mediaTypes = [kUTTypeImage as String];
            theController.allowsEditing = true;
            theController.delegate = self;
            presentViewController(theController, animated: true, completion: nil);
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("use photo")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height));
        imageView.image = image;
        
        presentViewController(picView!, animated: true, completion: nil);
 
        
        
    }
    
}
