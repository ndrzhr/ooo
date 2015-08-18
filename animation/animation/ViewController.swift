//
//  ViewController.swift
//  animation
//
//  Created by ndrzhr on 8/17/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var btn: UIButton!;
    let coloredSquare = UIView();
    
    let size:CGFloat = 50;
    let yPosition:CGFloat = 120;


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50));
        btn.center = view.center
        btn.backgroundColor = .grayColor();
        
        btn.addTarget(self, action: "btnbtn", forControlEvents: UIControlEvents.TouchUpInside) ;
        
        coloredSquare.backgroundColor = UIColor.blueColor()
        coloredSquare.frame = CGRectMake(0, yPosition, size, size)
        self.view.addSubview(coloredSquare)
        view.addSubview(btn);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func btnbtn(){
        
        let duration:NSTimeInterval =  1.0;
        let delay:NSTimeInterval = 0;
        let option = UIViewAnimationOptions.CurveLinear;
        let dumping:CGFloat = 0.2;
        let velocity:CGFloat  = 1.0;
        
        let size:CGFloat = CGFloat(arc4random_uniform(40))+20;
        let yPosition:CGFloat = CGFloat(arc4random_uniform( 200))+20;

     UIView.animateWithDuration(duration, delay: delay, options: option, animations: { () -> Void in
        self.coloredSquare.frame = CGRectMake(320-size, yPosition, size, size)
        self.view.addSubview(self.coloredSquare )
        }, completion: {finshed in
            self.coloredSquare.removeFromSuperview();
     })
        
    }
}

