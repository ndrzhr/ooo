//
//  CameraViewController.swift
//  GAT 0.2
//
//  Created by ndrzhr on 8/1/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController ,UINavigationBarDelegate,UIImagePickerControllerDelegate {
    // we use this vailable to determine if the viewDidApper method of our controller has been called or not . If not , we display the camera view ;
    var beenHereBefore = false;
    
    var controller : UIImagePickerController?;
    var imageFromCamera: UIImageView?;
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        if beenHereBefore{
            return;
        }else{
            beenHereBefore = true;
        }
        
        if isCameraAvialable() && doesCameraSupportTakingPhotos(){
            controller = UIImagePickerController();
            if let theController = controller{
                theController.sourceType = UIImagePickerControllerSourceType.Camera;
                theController.mediaTypes = [kUTTypeImage as String];
                theController.allowsEditing = true;
                theController.self;
                presentViewController(theController, animated: true, completion: nil);
            }
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("picker returned successfully");
        imageFromCamera?.image = image;
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = UIColor.yellowColor();
        imageFromCamera = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        imageFromCamera?.center = view.center;
        
        view.addSubview(imageFromCamera!);
        
    }
    
    
    func isCameraAvialable()-> Bool{
         return  UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera);
    }
    
    func cameraSupportMedia(mediaType: String, sourceType: UIImagePickerControllerSourceType) ->Bool{
        
        let avialableMediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType) as! [String];
        for type in avialableMediaTypes{
            if type == mediaType{
                return true;
            }
        }
        return false;
    }
    
    func doesCameraSupportTakingPhotos() ->Bool{
        return cameraSupportMedia(kUTTypeImage as String, sourceType: UIImagePickerControllerSourceType.Camera);
    }
    
    func doesCameraSupportTakingVideos() ->Bool{
        return cameraSupportMedia( kUTTypeAVIMovie as String, sourceType: UIImagePickerControllerSourceType.Camera);
    }
    
    func isFrontCameraAvilable() ->Bool{
        return UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front);
    }
    
    func isRearCameraAvilable() ->Bool{
        return UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear);
    }
    
    func isFlashAvialableOnFrontCamera() ->Bool{
        return UIImagePickerController.isFlashAvailableForCameraDevice(UIImagePickerControllerCameraDevice.Front);
    }
    
    func isFlashAvialableOnRearCamera() ->Bool{
        return UIImagePickerController.isFlashAvailableForCameraDevice(UIImagePickerControllerCameraDevice.Rear);
    }
}
