//
//  DetailViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/30.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var backgroundColor:UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.backgroundColor
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
