//
//  UserInterfaceCollectionViewCell.swift
//  GAT 0.7
//
//  Created by ndrzhr on 8/14/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation
import UIKit

class UserInterfaceCollectionViewCell: UICollectionViewCell{
    
    
    var textLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: (frame.size.height/6)*6))
        //imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.backgroundColor = UIColor.lightGrayColor();
        contentView.addSubview(imageView)
        
        //textLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height, width: frame.size.width, height: frame.size.height/6))
        //textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        //textLabel.textAlignment = .Center
        //contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
