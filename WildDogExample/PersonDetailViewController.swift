//
//  PersonDetailViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/20.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    var avatar:UIImageView!
    var name,label,de : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatar = UIImageView(frame: CGRectMake(150, 100, 60, 60))
                avatar.image = UIImage(named: "sun")
        avatar.center.x = SCREEN_WIDTH/2
        view.addSubview(avatar)
        
        for i in 1...5 {
            let cellView = UIView(frame: CGRectMake(0, 110+CGFloat(i)*60, SCREEN_WIDTH, 60))
            let leftLabel = UILabel(frame:CGRectMake(10,10,80,40))
            leftLabel.text = "\(i)"
            let rightLabel = UILabel(frame:CGRectMake(100,10,100,40))
            rightLabel.text = "\(i+1)"
            cellView.layer.borderWidth = 2.0
            cellView.layer.borderColor = UIColor.grayColor().CGColor
            cellView.addSubview(leftLabel)
            cellView.addSubview(rightLabel)
            view.addSubview(cellView)
        }
        // Do any additional setup after loading the view.
    }
    

}
