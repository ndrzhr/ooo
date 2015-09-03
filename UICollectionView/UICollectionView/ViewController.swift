//
//  ViewController.swift
//  UICollectionView
//
//  Created by ndrzhr on 9/1/15.
//  Copyright © 2015 ndrzhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let monsterNames = ["one","two","three","four"];
    let imageArray = [UIImage(named:"monsters-1"),UIImage(named: "monsters-2"),UIImage(named:"monsters-3"),UIImage(named: "monsters-4")];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell;
        
        cell.imageView?.image = self.imageArray[indexPath.row];
        cell.titleLabel?.text = self.monsterNames[indexPath.row];
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row);
        self.performSegueWithIdentifier("showImage", sender: self);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("hi");
        if segue.identifier == "showImage"
        {
            let indexPathes = self.collectionView!.indexPathsForSelectedItems()!;
            let indexPath = indexPathes[0] as NSIndexPath;
            
            let vc = segue.destinationViewController as! NewViewController
            vc.image = self.imageArray[indexPath.row]!;
            vc.title = self.monsterNames[indexPath.row];
        }
    }
    
    
}

