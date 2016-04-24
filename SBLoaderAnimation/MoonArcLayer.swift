//
//  MoonArcLayer.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/6.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

import UIKit

class MoonArcLayer: CAShapeLayer {
    
    let animationDuration: CFTimeInterval = 0.18
    let rectHeight: CGFloat = 70.0
    let rectWidth: CGFloat = 100.0
    let sidePace: CGFloat = 0.2
    override init() {
        super.init()
        fillColor = Colors.blue.CGColor
        path = arcPathPre.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var arcPathPre: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.moveToPoint(CGPoint(x: 0.0, y: rectHeight))
        arcPath.addCurveToPoint(CGPoint(x: rectWidth, y: 0),controlPoint1: CGPoint(x: 50.0, y: rectHeight * 0.5 ), controlPoint2: CGPoint(x:50.0,y:rectHeight * 0.5))
        arcPath.addCurveToPoint(CGPoint(x: 0, y: rectHeight),controlPoint1: CGPoint(x: rectWidth, y: rectHeight ), controlPoint2: CGPoint(x:rectWidth,y:rectHeight))
        arcPath.closePath()
        return arcPath
    }

    
    func animate() {
        var arcAnimationPre: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationPre.fromValue = arcPathPre.CGPath
        arcAnimationPre.toValue = arcPathPre.CGPath
        arcAnimationPre.beginTime = 0.0
        arcAnimationPre.duration = animationDuration
        
        var arcAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        arcAnimationGroup.animations = [arcAnimationPre]
        arcAnimationGroup.duration = arcAnimationPre.beginTime + arcAnimationPre.duration
        arcAnimationGroup.fillMode = kCAFillModeForwards
        arcAnimationGroup.removedOnCompletion = false
        addAnimation(arcAnimationGroup, forKey: nil)
    }
}
