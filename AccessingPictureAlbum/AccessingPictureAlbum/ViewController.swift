//
//  ViewController.swift
//  AccessingPictureAlbum
//
//  Created by ndrzhr on 8/3/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import MobileCoreServices
import Parse
class ViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate  {
    
    var btnCamera: UIButton!;
    var btnImage = UIImage(named: "btnCamPic");
    var btnAlbum: UIButton!;
    var btnRetrive:UIButton!;
    let btnAlbumImage = UIImage(named: "photoAlbumIcon");
    let btnRetriveImage = UIImage(named: "monsters-02");
    
    var cameraController: UIImagePickerController?;
    var action: UIAlertAction?;
    var userInput = "";
    
    var userPhoto:PFObject?;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCamera = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80));
        btnCamera.setImage(btnImage, forState: UIControlState.Normal);
        btnCamera.center = view.center;
        btnCamera.addTarget(self, action: "btnCameraPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        btnAlbum = UIButton(frame: CGRect(x: view.center.x - 40, y: view.center.y + 90, width: 80, height: 80));
        btnAlbum.setImage(btnAlbumImage, forState: UIControlState.Normal);
        btnAlbum.addTarget(self, action: "btnPhotoAlbumPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        btnRetrive = UIButton(frame: CGRect(x: view.center.x - 40 , y: view.center.y + 180, width: 80, height: 80)
        );
        btnRetrive.setImage(btnRetriveImage, forState: UIControlState.Normal);
        btnRetrive.addTarget(self, action: "btnRetrivePressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        view.addSubview(btnRetrive);
        view.addSubview(btnAlbum);
        view.addSubview(btnCamera);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnPhotoAlbumPressed(sender: UIButton){
        var imagePickerController = UIImagePickerController();
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imagePickerController.allowsEditing = true;
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    func btnCameraPressed(sender: UIButton){
        println("click")
        if isCameraAvialable(){
            
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
    
    func isCameraAvialable()->Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera);
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        var userPhoto = PFObject(className: "userPhoto");


        if picker.sourceType == UIImagePickerControllerSourceType.Camera{
            picker.dismissViewControllerAnimated(true, completion: nil);

            let imageData = UIImagePNGRepresentation(image);
            let imageFile = PFFile(name: "image.png", data: imageData);
            userPhoto["imagename"] = "camera1";
            userPhoto["imageFile"] = imageFile;
            
                    }
        else{
            picker.dismissViewControllerAnimated(true, completion: nil);

        let imageData = UIImagePNGRepresentation(image);
        let imageFile = PFFile(name: "image.png", data: imageData);
            
        userPhoto["imageName"] = "album";
        userPhoto["imageFile"] = imageFile;
        }
        
        var alert = UIAlertController(title: "***", message: "*****", preferredStyle: UIAlertControllerStyle.Alert);

        action = UIAlertAction(title: "save", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            
            userPhoto["textInput"] = self.userInput;
            userPhoto.saveInBackground();

        });
        alert.addAction(action!);
        alert.addTextFieldWithConfigurationHandler { (tf: UITextField!) -> Void in
            
            tf.addTarget(self, action: "textChanged:", forControlEvents: UIControlEvents.EditingDidEnd);
            
        }

        presentViewController(alert, animated: true, completion: nil);
    }
    
    func textChanged(sender: AnyObject){
        let tf = sender as! UITextField;
        println(tf.text)
        userInput = tf.text;
    }
    
    
    func btnRetrivePressed(sender:UIButton){
        
        var retrivedView = BlaBlaView();
        retrivedView.view.backgroundColor = UIColor.lightGrayColor();
        retrivedView.imageBlaBla!.image = UIImage(named: "monsters-02");
        retrivedView.textBlaBla?.text = "Hi"
        
        var query = PFQuery(className: "userPhoto");
        
        
        query.getObjectInBackgroundWithId("ZddXPWYUma", block: { (blabla: PFObject?, error:NSError?) -> Void in
            if error == nil && blabla != nil{
                println(blabla)
                
                var imageData:NSData?
                println(blabla);
               // let userImageFile = anotherPhoto["imageFile"] as PFFile;
                
                

                retrivedView.textBlaBla?.text =  blabla?.objectForKey("textInput") as? String;
                
            }else{
                println(error);
            }
            
            
            
            /*
            query.findObjectsInBackgroundWithBlock({[weak self] (objects:[AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let object = objects as? [PFObject]{
                       println(object.description)
                       // let userImageFile = anotherPhoto["imageFile"] as! Pffile;

                        var userImageFile = object["imageFile"] as! NSData;
                        var image01 = UIImage(data: userImageFile);
                        retrivedView.imageBlaBla?.image = image01;

                        
                        
                    }
                }
                });
*/
            
            
            /*
            var image = UIImage();
            let imageData = UIImagePNGRepresentation(image);
            let imageFile = PFFile(name: "image.png", data: imageData)
            
            var anotherUserPhot = PFObject(className: "usserPhoto");
            
            
            let userImageFile = anotherUserPhot["imageFile"] as! PFFile;
            anotherUserPhot.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if error == nil{
                    if let imageData = imageData{
                        let image = UIImage(data: imageData)
                        retrivedView.imageBlaBla?.image = image;

        }
                }
            })*/
            
            

            
        });
 
        self.presentViewController(retrivedView, animated: true, completion: nil);
        
    }
    
}

