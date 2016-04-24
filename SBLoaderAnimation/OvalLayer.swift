//
//  OvalLayer.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-19.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

class OvalLayer: CAShapeLayer {
  

    let animationDuration: CFTimeInterval = 0.5
    let pace: CGFloat = 150
    override init() {
      super.init()
      fillColor = Colors.red.CGColor
      path = ovalPathSmall.CGPath
    }
  
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Path
    var ovalPathSmall: UIBezierPath {
      return UIBezierPath(ovalInRect: CGRect(x: 50.0, y: 50.0 - pace, width: 0.0, height: 0.0))
    }
  
    var ovalPathSmall2: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 50.0 + 120, y: 50.0 - pace, width: 0.0, height: 0.0))
    }
    
    var ovalPathSmall3: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 50.0 - 120, y: 50.0 - pace, width: 0.0, height: 0.0))
    }
    var ovalPathLarge: UIBezierPath {
      return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 17.5 - pace, width: 95.0, height: 95.0))
    }
  
    var ovalPathLarge2: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 2.5 + 120, y: 17.5 - pace, width: 95.0, height: 95.0))
    }
    
    var ovalPathLarge3: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: 2.5 - 120, y: 17.5 - pace, width: 95.0, height: 95.0))
    }
  var ovalPathSquishVertical: UIBezierPath {
    return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 20.0 - pace, width: 95.0, height: 90.0))
  }
  
  var ovalPathSquishHorizontal: UIBezierPath {
    return UIBezierPath(ovalInRect: CGRect(x: 5.0, y: 20.0 - pace, width: 90.0, height: 90.0))
  }
  
  //MARK: Action
  func expand() {
    
    var expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
    expandAnimation.fromValue = ovalPathSmall.CGPath
    expandAnimation.toValue = ovalPathLarge.CGPath
    expandAnimation.beginTime = 0.0
    expandAnimation.duration = animationDuration
    expandAnimation.fillMode = kCAFillModeForwards
    expandAnimation.removedOnCompletion = false
    
    var expandAnimation2: CABasicAnimation = CABasicAnimation(keyPath: "path")
    expandAnimation2.fromValue = ovalPathSmall2.CGPath
    expandAnimation2.toValue = ovalPathLarge2.CGPath
    expandAnimation2.beginTime = expandAnimation.beginTime + expandAnimation.duration
    expandAnimation2.duration = animationDuration
    expandAnimation2.fillMode = kCAFillModeForwards
    expandAnimation2.removedOnCompletion = false
    
    var expandAnimation3: CABasicAnimation = CABasicAnimation(keyPath: "path")
    expandAnimation3.fromValue = ovalPathSmall3.CGPath
    expandAnimation3.toValue = ovalPathLarge3.CGPath
    expandAnimation3.beginTime = expandAnimation2.beginTime + expandAnimation2.duration
    expandAnimation3.duration = animationDuration
    expandAnimation3.fillMode = kCAFillModeForwards
    expandAnimation3.removedOnCompletion = false
    
    var expandAnimationGroup: CAAnimationGroup = CAAnimationGroup()
    expandAnimationGroup.animations = [expandAnimation, expandAnimation2, expandAnimation3]
    expandAnimationGroup.duration = expandAnimation3.beginTime + expandAnimation3.duration
    expandAnimationGroup.repeatCount = 1
    addAnimation(expandAnimationGroup, forKey: nil)
    
    
  }
    func expand2() {
        var expandAnimation2: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation2.fromValue = ovalPathSmall2.CGPath
        expandAnimation2.toValue = ovalPathLarge2.CGPath
        expandAnimation2.duration = animationDuration
        expandAnimation2.fillMode = kCAFillModeForwards
        expandAnimation2.removedOnCompletion = false
        addAnimation(expandAnimation2, forKey: nil)
        
    }
  func wobble() {
    // 1
    var wobbleAnimation1: CABasicAnimation = CABasicAnimation(keyPath: "path")
    wobbleAnimation1.fromValue = ovalPathLarge.CGPath
    wobbleAnimation1.toValue = ovalPathSquishVertical.CGPath
    wobbleAnimation1.beginTime = 0.0
    wobbleAnimation1.duration = animationDuration
    
    // 2
    var wobbleAnimation2: CABasicAnimation = CABasicAnimation(keyPath: "path")
    wobbleAnimation2.fromValue = ovalPathSquishVertical.CGPath
    wobbleAnimation2.toValue = ovalPathSquishHorizontal.CGPath
    wobbleAnimation2.beginTime = wobbleAnimation1.beginTime + wobbleAnimation1.duration
    wobbleAnimation2.duration = animationDuration
    
    // 3
    var wobbleAnimation3: CABasicAnimation = CABasicAnimation(keyPath: "path")
    wobbleAnimation3.fromValue = ovalPathSquishHorizontal.CGPath
    wobbleAnimation3.toValue = ovalPathSquishVertical.CGPath
    wobbleAnimation3.beginTime = wobbleAnimation2.beginTime + wobbleAnimation2.duration
    wobbleAnimation3.duration = animationDuration
    
    // 4
    var wobbleAnimation4: CABasicAnimation = CABasicAnimation(keyPath: "path")
    wobbleAnimation4.fromValue = ovalPathSquishVertical.CGPath
    wobbleAnimation4.toValue = ovalPathLarge.CGPath
    wobbleAnimation4.beginTime = wobbleAnimation3.beginTime + wobbleAnimation3.duration
    wobbleAnimation4.duration = animationDuration
    
    // 5
    var wobbleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
    wobbleAnimationGroup.animations = [wobbleAnimation1, wobbleAnimation2, wobbleAnimation3,
        wobbleAnimation4]
    wobbleAnimationGroup.duration = wobbleAnimation4.beginTime + wobbleAnimation4.duration
    wobbleAnimationGroup.repeatCount = 2
    addAnimation(wobbleAnimationGroup, forKey: nil)
    
  }
  
  func contract() {
    var contractAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
    contractAnimation.fromValue = ovalPathLarge.CGPath
    contractAnimation.toValue = ovalPathSmall.CGPath
    contractAnimation.duration = animationDuration
    contractAnimation.fillMode = kCAFillModeForwards
    contractAnimation.removedOnCompletion = false
    addAnimation(contractAnimation, forKey: nil)
    
  }
}
