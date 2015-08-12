//
//  CollectionViewFeed.swift
//  GAT 0.6
//
//  Created by ndrzhr on 8/11/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class CollectionViewFeed: UIViewController, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var collectionView: UICollectionView!;
    var point: CGPoint!;
    var size: CGSize!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //----
        point = CGPoint(x: 0, y: 0);
        size = CGSize(width: view.bounds.width/2 - 22 , height: view.bounds.height / 3);
        var cellFrame = CGRect(origin: point, size: size);
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 122, left: 10, bottom: 40, right: 10);
        layout.itemSize = size;
        //----
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout);
        collectionView.center = view.center;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        
        
        
    }
    
    
   
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewFeedCell;
        var cellView = UIView(frame: CGRect(origin:self.point, size: self.size))
        cellView.backgroundColor = UIColor.whiteColor();
        
        return cell;
        
    }
    
}

