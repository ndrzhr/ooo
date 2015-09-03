//
//  FirstViewController.swift
//  GAT 0.8.3
//
//  Created by ndrzhr on 9/3/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit
import Parse
import Bolts
import CoreLocation

class FirstViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let monstersName = ["one","two","three","four"]
    let imageArray = [UIImage(named: "monsters-01"),UIImage(named: "monsters-02"),UIImage(named: "monsters-03"),UIImage(named: "monsters-04")]

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.monstersName.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell;
        cell.imageView?.image = self.imageArray[indexPath.row];
        cell.lable?.text = self.monstersName[indexPath.row];
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems();
            let indexPath = indexPaths[0] as! NSIndexPath;
            
            let vc = segue.destinationViewController as! ItemViewController;
            vc.image = self.imageArray[indexPath.row]!;
            vc.title = self.monstersName[indexPath.row];
            
            
        }
    }

}

