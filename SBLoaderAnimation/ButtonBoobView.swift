//
//  ButtonBoobView.swift
//  SBLoader
//
//  Created by yrq_mac on 15/10/15.
//  Copyright © 2015年 Satraj Bambra. All rights reserved.
//

import UIKit

protocol ButtonBoobViewDelegate:class {
    func animateLabel()
}

class ButtonBoobView: UIView {
    
    //MARK: Properties
    let ovalLayer = OvalLayer()
    let triangleLayer = TriangleLayer()
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let arcLayer = ArcLayer()
//    let arcLayer = MoonArcLayer()
    
    var parentFrame :CGRect = CGRectZero
    weak var delegate:ButtonBoobViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Action
    func addOval() {
        
//        layer.addSublayer(blueRectangleLayer)
//        blueRectangleLayer.animateStrokeWithColor(Colors.blue)
        
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "rectExpand", userInfo: nil, repeats: false)
    }
    
    func rectExpand() {
        layer.addSublayer(arcLayer)
        arcLayer.animate()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "addCircle", userInfo: nil, repeats: false)
    }
    
    
    func addCircle() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
    }
    
}

