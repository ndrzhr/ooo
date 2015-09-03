//
//  ItemViewController.swift
//  GAT 0.8.3
//
//  Created by ndrzhr on 9/3/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation
import UIKit

class ItemViewController: UIViewController{
    
    var image = UIImage();
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.imageView.image = self.image;
    }
}
