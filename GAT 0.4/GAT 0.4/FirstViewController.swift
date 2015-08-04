//
//  FirstViewController.swift
//  GAT 0.4
//
//  Created by ndrzhr on 8/2/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import MobileCoreServices
import Parse 

class FirstViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UISearchBarDelegate {
    
    var searchBar: UISearchBar!;
    
    var collectionView:UICollectionView!;

    
    var point: CGPoint!;
    var size: CGSize!;
    var btnCamera: UIButton!;
    let btnImage: UIImage = UIImage(named: "redCamera")!;
    var images:[UIImage] = [UIImage]();
    
    
    var cameraController: UIImagePickerController?;
    var imageFromCamera: UIImageView?;
    
    var isFirstTime: Bool = true;
    
    

    
    

    //----------------------------------
    var tableData:[String] = ["monster-01","monster-02","monster-03","monster-04","monster-05","monster-06","monster-07","monster-08","monster-09","monster-10","monster-11","monster-12","monster-13","monster-14","monster-15","monster-16"];
    var tableImages:[String] = ["monsters-01","monsters-02","monsters-03","monsters-04","monsters-05","monsters-06","monsters-07","monsters-08","monsters-09","monsters-10","monsters-11","monsters-12","monsters-13","monsters-14","monsters-15","monsters-16"];
    //-----------------------------------

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        if isFirstTime{
            isFirstTime = false;
            var firstTimeAlert = UIAlertController(title: "first time alert", message: "your first time in the sea?", preferredStyle: UIAlertControllerStyle.Alert);
            var actionOk = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil);
            var actionCancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil);
            firstTimeAlert.addAction(actionOk);
            firstTimeAlert.addAction(actionCancel);
            presentViewController(firstTimeAlert, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //----
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved.")
        }
        
        //----
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 80));
        searchBar.delegate = self;
        searchBar.autocorrectionType = UITextAutocorrectionType.No;
        searchBar.backgroundColor = UIColor.whiteColor();
        searchBar.searchBarStyle = UISearchBarStyle.Minimal;
        
        
        
        point = CGPoint(x: 0, y: 0)
        size = CGSize(width: view.bounds.width/2 - 22 , height: view.bounds.height / 3);
        var cellFrame = CGRect(origin: point, size: size);
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 122, left: 10, bottom: 40, right: 10);
        layout.itemSize = size ;
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout);
        collectionView.center = view.center;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell");
        collectionView.backgroundColor = UIColor.lightGrayColor();
        self.view.addSubview(collectionView);
        
        btnCamera = UIButton(frame: CGRect(x: view.bounds.width / 2 - 35, y: view.bounds.height - 140, width: 70, height: 70));
        btnCamera.setImage(btnImage, forState: UIControlState.Normal);
        btnCamera.addTarget(self, action: "btnCameraPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        
        view.addSubview(searchBar);
        view.addSubview(btnCamera);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true);
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = "";
        searchBar.setShowsCancelButton(false, animated: true);
        searchBar.resignFirstResponder();
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count;
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellView = UIView(frame: CGRect(origin:point, size: size))
        cellView.backgroundColor = UIColor.whiteColor();
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell;
        var lableCell = UILabel(frame: CGRect(x: 0, y: size.height - 20, width: size.width, height: 20));
        lableCell.text = tableData[indexPath.row]
        lableCell.backgroundColor = UIColor.whiteColor();
        var imageViewCell = UIImageView(frame: CGRect(x: 0, y: 0, width: cellView.bounds.width, height: cellView.bounds.height - lableCell.bounds.height))
        imageViewCell.image = UIImage(named: tableImages[indexPath.row]);
        cellView.addSubview(imageViewCell);
        cellView.addSubview(lableCell);
        cell.addSubview(cellView);
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(" you have clicked at pic \(indexPath.row)")
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("\(indexPath.row)")
    }
    
    
    func btnCameraPressed(sender: UIButton){
        println("camera is pressed");
        
        if isCameraAvialble(){
            cameraController = UIImagePickerController();
            
            if let theController = cameraController{
                theController.sourceType = UIImagePickerControllerSourceType.Camera;
                theController.mediaTypes = [kUTTypeImage as String];
                theController.allowsEditing = true;
                theController.delegate = self;
                presentViewController(theController, animated: true, completion: nil);
            }
        }
    }
    
    func isCameraAvialble()-> Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera);
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

        picker.dismissViewControllerAnimated(true, completion: nil);
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    
    private var offsetSearchBarLeft:CGFloat
        {
        get {
            return 93
        }
    }
    
    ///Enlarges search bar
    func searchBarDidBeginEditing(searchBar: UISearchBar) {
        
        self.animateSearchBar(self.searchBar, enlarge: true)
    }
    
    ///Shrinks search bar
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        self.animateSearchBar(self.searchBar, enlarge: false)
    }
    
    //shrinks or enlarge the searchbar (this will be the function to call inside the animation)
    private func animateSearchBar(searchBar:UISearchBar, enlarge:Bool)
    {
        ///Important here, for this to work, the option and the searchbar size must be handled this way
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.LayoutSubviews, animations: { [weak self] () -> Void in
            
            let multiplier: CGFloat = enlarge ? 1 : -1
            
            let origin = searchBar.frame.origin.x + self!.offsetSearchBarLeft * multiplier
            let width = searchBar.frame.width + self!.offsetSearchBarLeft * multiplier
            
            //This Block of code, setting the new frame, needs to be inside the animation in order to work
            var newBounds:CGRect  = searchBar.frame;
            newBounds.origin.x = origin
            newBounds.size.width = width
            
            //Sets the new frame
            //self?.searchBarWidth.constant = width
            searchBar.frame = newBounds
            
            }, completion: nil)
    }
    
    
    


}

