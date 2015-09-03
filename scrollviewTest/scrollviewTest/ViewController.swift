//
//  ViewController.swift
//  scrollviewTest
//
//  Created by ndrzhr on 8/20/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewOne = UIView();
    var viewTwo = UIView();
    var scrollView = UIScrollView();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height));
        scrollView.pagingEnabled = true;
        viewOne = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 500));
        viewTwo = UIView(frame: CGRect(x: 0, y: 500, width: self.view.bounds.width, height: 500));
        viewOne.backgroundColor = .blueColor();
        viewTwo.backgroundColor = .yellowColor();
        scrollView.contentSize = CGSizeMake(view.bounds.width, 1000);
        scrollView.addSubview(viewOne);
        scrollView.addSubview(viewTwo);
        view.addSubview(scrollView);
        
       // view.addSubview(viewTwo);
       // view.addSubview(viewOne);
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

