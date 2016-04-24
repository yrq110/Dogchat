//
//  RectangleLayer.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-20.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

class RectangleLayer: CAShapeLayer {
  
  override init() {
    super.init()
    fillColor = Colors.clear.CGColor
    lineWidth = 5.0
    path = rectanglePathFull.CGPath
//    path = ytimePathFull.CGPath
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    var ytimePathFull: UIBezierPath {
        let ytimePath = UIBezierPath()
        ytimePath.moveToPoint(CGPoint(x: 13.0, y: 15.0))
        ytimePath.addLineToPoint(CGPoint(x: 48.0, y: 50.0))
        ytimePath.addLineToPoint(CGPoint(x: 48.0, y: 100.0))
        ytimePath.addLineToPoint(CGPoint(x: 52.0, y: 100.0))
        ytimePath.addLineToPoint(CGPoint(x: 52.0, y: 50.0))
        ytimePath.addLineToPoint(CGPoint(x: 87.0, y: 15.0))
        ytimePath.addLineToPoint(CGPoint(x: 83.0, y: 15.0))
        ytimePath.addLineToPoint(CGPoint(x: 52.0, y: 100.0))
        ytimePath.addLineToPoint(CGPoint(x: 50.0, y: 48.0))
        ytimePath.addLineToPoint(CGPoint(x: 17.0, y: 15.0))
        ytimePath.closePath()
        return ytimePath
    }

  var rectanglePathFull: UIBezierPath {
    let rectanglePath = UIBezierPath()
    rectanglePath.moveToPoint(CGPoint(x: 0.0, y: 70.0))
    rectanglePath.addLineToPoint(CGPoint(x: 0.0, y: -lineWidth))
    rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: -lineWidth))
    rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: 70.0))
    rectanglePath.addLineToPoint(CGPoint(x: -lineWidth / 2, y: 70.0))
    rectanglePath.closePath()
    return rectanglePath
  }
  
  func animateStrokeWithColor(color: UIColor) {
    strokeColor = color.CGColor
    var strokeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    strokeAnimation.fromValue = 0.0
    strokeAnimation.toValue = 1.0
    strokeAnimation.duration = 0.4
    addAnimation(strokeAnimation, forKey: nil)
  }
    
    func writeY() {
        var ytimeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        ytimeAnimation.fromValue = ytimePathFull.CGPath
        ytimeAnimation.toValue = ytimePathFull.CGPath
        ytimeAnimation.duration = 0.45
        ytimeAnimation.fillMode = kCAFillModeForwards
        ytimeAnimation.removedOnCompletion = false
        addAnimation(ytimeAnimation, forKey: nil)
    }
    
}
