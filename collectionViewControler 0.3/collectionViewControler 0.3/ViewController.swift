//
//  ViewController.swift
//  collectionViewControler 0.3
//
//  Created by ndrzhr on 7/27/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    var tableData:[String] = ["one","two","three","four","five","six","seven","eight","nine"];
    var tableImages:[String]=["monsters-01","monsters-02","monsters-03","monsters-04","monsters-05","monsters-06","monsters-07","monsters-08","monsters-09"]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: colvwCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)as! colvwCell;
        cell.lblCell.text = tableData[indexPath.row];
        cell.imgCell.image = UIImage(named: tableImages[indexPath.row]);
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell \(indexPath.row) selected")

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

