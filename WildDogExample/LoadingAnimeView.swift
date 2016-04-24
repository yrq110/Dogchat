//
//  LoadingAnimeView.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/8.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class LoadingAnimeView: UIView {

    var movePoints:Array<CGPoint>!
    var tile:UIView!
    var tile2:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.playAnimation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    func playAnimation()
    {
        self.backgroundColor = UIColor.clearColor()
        
        tile = UIView(frame: CGRectMake(0,0,30,30))
//        print(tile.center)
        tile.backgroundColor = UIColor.redColor()
        tile.layer.masksToBounds = true
        tile.layer.cornerRadius = 8.0
        self.addSubview(tile)
        
        tile2 = UIView(frame: CGRectMake(75,100,30,30))
//        print(tile2.center)
        tile2.backgroundColor = UIColor.greenColor()
        tile2.layer.masksToBounds = true
        tile2.layer.cornerRadius = 8.0
        self.addSubview(tile2)
        
        self.movePoints = Array<CGPoint>()
        self.movePoints.append(CGPoint(x:90,y:15))
        self.movePoints.append(CGPoint(x:90,y:115))
        self.movePoints.append(CGPoint(x:15,y:115))
        self.movePoints.append(CGPoint(x:15,y:15))
        self.moveAnime()
    }
    
    
    func moveAnime(){
        
        self.moveFunc(0.5, rotateDuration: 0.5, point: self.movePoints[0], angle: 90)
        
        self.moveFunc2(0.5, rotateDuration: 0.5, point: self.movePoints[2], angle: 90)
    }
    
    var i = 0
    func moveFunc(moveDuration:Double, rotateDuration:Double, point:CGPoint, angle:Double){
        UIView.animateWithDuration(moveDuration, animations: {
            self.tile.center = point
            //            self.tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.5,0.5))
//            print(self.tile.frame)
            }, completion:{
                (finished:Bool) -> Void in
                UIView.animateWithDuration(rotateDuration, animations: {
                    let a:CGFloat = CGFloat(angle*(M_PI/180.0))
                    self.tile.transform = CGAffineTransformMakeRotation(a)},completion:{
                        (finished:Bool) -> Void in
                        self.i++; if self.i == 4 { self.i=0 }
                        self.moveFunc(moveDuration, rotateDuration: rotateDuration, point: self.movePoints[self.i], angle: angle+90.0)
                    }
                )
            }
        )
    }
    
    var j = 2
    func moveFunc2(moveDuration:Double, rotateDuration:Double, point:CGPoint, angle:Double){
        UIView.animateWithDuration(moveDuration, animations: {
            self.tile2.center = point
            }, completion:{
                (finished:Bool) -> Void in
                UIView.animateWithDuration(rotateDuration, animations: {
                    let a:CGFloat = CGFloat(angle*(M_PI/180.0))
                    self.tile2.transform = CGAffineTransformMakeRotation(a)},completion:{
                        (finished:Bool) -> Void in
                        self.j++; if self.j == 4 { self.j=0 }
                        self.moveFunc2(moveDuration, rotateDuration: rotateDuration, point: self.movePoints[self.j], angle: angle+90.0)
                    }
                )
            }
        )
        
    }
    
}
