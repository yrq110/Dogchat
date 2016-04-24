//
//  ArcLayer.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-20.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

class ArcLayer: CAShapeLayer {
  
    let animationDuration: CFTimeInterval = 0.18
    let rectHeight: CGFloat = 70.0
    let rectWidth: CGFloat = 100.0
    let sidePace: CGFloat = 0.2
  override init() {
    super.init()
    fillColor = Colors.blue.CGColor
    path = arcPathStarting.CGPath
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var arcPathPre: UIBezierPath {
    let arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight - 1))
    arcPath.addLineToPoint(CGPoint(x: rectWidth, y: rectHeight - 1))
    arcPath.addLineToPoint(CGPoint(x: rectWidth, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.closePath()
    return arcPath
  }
  
  var arcPathStarting: UIBezierPath {
    let arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight * 0.8))
    arcPath.addCurveToPoint(CGPoint(x: rectWidth, y: rectHeight * 0.8 ),controlPoint1: CGPoint(x: 30.0, y: rectHeight * 0.7 ), controlPoint2: CGPoint(x: 40.0, y: rectHeight * 0.9))
    arcPath.addLineToPoint(CGPoint(x: rectWidth, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.closePath()
    return arcPath
  }
  
  var arcPathLow: UIBezierPath {
    let arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight * 0.6))
    arcPath.addCurveToPoint(CGPoint(x: rectWidth, y: rectHeight * 0.6), controlPoint1: CGPoint(x: 30.0, y: rectHeight * 0.7), controlPoint2: CGPoint(x: 40.0, y: rectHeight * 0.5))
    arcPath.addLineToPoint(CGPoint(x: rectWidth, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.closePath()
    return arcPath
  }
  
  var arcPathMid: UIBezierPath {
    let arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight * 0.4))
    arcPath.addCurveToPoint(CGPoint(x: rectWidth, y: rectHeight * 0.4), controlPoint1: CGPoint(x: 30.0, y: rectHeight * 0.5), controlPoint2: CGPoint(x: 40.0, y: rectHeight * 0.3))
    arcPath.addLineToPoint(CGPoint(x: rectWidth, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.closePath()
    return arcPath
  }
  
  var arcPathHigh: UIBezierPath {
    let arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: rectHeight * 0.2))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight * 0.2))
    arcPath.addCurveToPoint(CGPoint(x: rectWidth, y: rectHeight * 0.2), controlPoint1: CGPoint(x: 30.0, y: rectHeight * 0.3), controlPoint2: CGPoint(x: 40.0, y: rectHeight * 0.1))
    arcPath.addLineToPoint(CGPoint(x: rectWidth, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.closePath()
    return arcPath
  }
  
  var arcPathComplete: UIBezierPath {
    let arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: -5.0))
    arcPath.addLineToPoint(CGPoint(x: rectWidth, y: -5.0))
    arcPath.addLineToPoint(CGPoint(x: rectWidth, y: rectHeight))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: rectHeight))
    arcPath.closePath()
    return arcPath
  }
  
  func animate() {
    var arcAnimationPre: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationPre.fromValue = arcPathPre.CGPath
    arcAnimationPre.toValue = arcPathStarting.CGPath
    arcAnimationPre.beginTime = 0.0
    arcAnimationPre.duration = animationDuration
    
    var arcAnimationLow: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationLow.fromValue = arcPathStarting.CGPath
    arcAnimationLow.toValue = arcPathLow.CGPath
    arcAnimationLow.beginTime = arcAnimationPre.beginTime + arcAnimationPre.duration
    arcAnimationLow.duration = animationDuration
    
    var arcAnimationMid: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationMid.fromValue = arcPathLow.CGPath
    arcAnimationMid.toValue = arcPathMid.CGPath
    arcAnimationMid.beginTime = arcAnimationLow.beginTime + arcAnimationLow.duration
    arcAnimationMid.duration = animationDuration
    
    var arcAnimationHigh: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationHigh.fromValue = arcPathMid.CGPath
    arcAnimationHigh.toValue = arcPathHigh.CGPath
    arcAnimationHigh.beginTime = arcAnimationMid.beginTime + arcAnimationMid.duration
    arcAnimationHigh.duration = animationDuration
    
    var arcAnimationComplete: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationComplete.fromValue = arcPathHigh.CGPath
    arcAnimationComplete.toValue = arcPathComplete.CGPath
    arcAnimationComplete.beginTime = arcAnimationHigh.beginTime + arcAnimationHigh.duration
    arcAnimationComplete.duration = animationDuration
    
    var arcAnimationGroup: CAAnimationGroup = CAAnimationGroup()
    arcAnimationGroup.animations = [arcAnimationPre, arcAnimationLow, arcAnimationMid,
        arcAnimationHigh, arcAnimationComplete]
    arcAnimationGroup.duration = arcAnimationComplete.beginTime + arcAnimationComplete.duration
    arcAnimationGroup.fillMode = kCAFillModeForwards
    arcAnimationGroup.removedOnCompletion = false
    addAnimation(arcAnimationGroup, forKey: nil)
    
//    var arcAnimationGroup2: CAAnimationGroup = CAAnimationGroup()
//    arcAnimationGroup2.animations = [arcAnimationComplete,arcAnimationHigh,arcAnimationMid,arcAnimationLow,arcAnimationPre]
//    arcAnimationGroup2.duration = arcAnimationPre.beginTime + arcAnimationPre.duration
//    arcAnimationGroup2.fillMode = kCAFillModeForwards
//    arcAnimationGroup2.removedOnCompletion = false
//    addAnimation(arcAnimationGroup,arcAnimationGroup2 forKey: nil)

  }
}
