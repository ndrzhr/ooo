//
//  BlaBlaView.swift
//  AccessingPictureAlbum
//
//  Created by ndrzhr on 8/3/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation
import UIKit

class BlaBlaView:UIViewController{
    
    
    var imageBlaBla:UIImageView?;
    var textBlaBla: UILabel?;
    
    
    
    override func viewDidLoad() {
        imageBlaBla = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300));
        
        textBlaBla = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40));
        textBlaBla?.center = view.center;
        textBlaBla?.backgroundColor = UIColor.whiteColor();
        view.addSubview(textBlaBla!);
        view.addSubview(imageBlaBla!);
    }

    
}
