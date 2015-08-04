//
//  FirstViewController.swift
//  GAT 0.3
//
//  Created by ndrzhr on 8/2/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!;
    
    //----------------------------------
    var tableData:[String] = ["monster-01","monster-02","monster-03","monster-04","monster-05","monster-06","monster-07","monster-08","monster-09","monster-10","monster-11","monster-12","monster-13","monster-14","monster-15","monster-16"];
    var tableImages:[String] = ["monsters-01","monsters-02","monsters-03","monsters-04","monsters-05","monsters-06","monsters-07","monsters-08","monsters-09","monsters-10","monsters-11","monsters-12","monsters-13","monsters-14","monsters-15","monsters-16"];
    //-----------------------------------


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10);
        layout.itemSize = CGSize(width: 90, height: 120);
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell");
        collectionView.backgroundColor = UIColor.whiteColor();
        self.view.addSubview(collectionView);
        
        
        
 
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell;
        cell.backgroundColor = UIColor.orangeColor();
        return cell ;
    }

}

