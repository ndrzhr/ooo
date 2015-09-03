//
//  CollectionViewCell.swift
//  GAT 0.8
//
//  Created by ndrzhr on 8/30/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//


import Foundation
import UIKit
import Parse
import Bolts

class CollectionViewCell: UICollectionViewCell{
    
    
    var textLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: (frame.size.height/6)*5))
        //imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.backgroundColor = UIColor.lightGrayColor();
        contentView.addSubview(imageView)
        
        textLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height, width: frame.size.width, height: frame.size.height/6))
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        contentView.addSubview(textLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
