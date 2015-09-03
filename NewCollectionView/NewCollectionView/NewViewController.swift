//
//  NewViewController.swift
//  NewCollectionView
//
//  Created by ndrzhr on 9/1/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//
import Foundation
import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage();
    
    override func viewDidLoad() {
        self.imageView.image = self.image;
    }
}
