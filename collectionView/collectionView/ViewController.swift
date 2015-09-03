//
//  ViewController.swift
//  collectionView
//
//  Created by ndrzhr on 8/30/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    let imageName = ["one","two","three","four"]
    let imageArray = [UIImage(named: "monsters-01"),UIImage(named: "monsters-02"),UIImage(named: "monsters-03"),UIImage(named: "monsters-04")];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageName.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell;
        cell.imageView.image = self.imageArray[indexPath.row];
        cell.titleLable.text = self.imageName[indexPath.row];
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!;
            
            let indexPath = indexPaths[0] as NSIndexPath;
            
            
            let vc = segue.destinationViewController as! NewViewController
            vc.image = self.imageArray[indexPath.row]!;
            vc.title = self.imageName[indexPath.row]
        }
    }
    

}
