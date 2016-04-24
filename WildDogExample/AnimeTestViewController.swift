//
//  AnimeTestViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/3.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class AnimeTestViewController: UIViewController {

    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

    var dimension:Int = 4
    var width:CGFloat = 50
    var padding:CGFloat = 6
    
    var backgrounds:Array<UIView>!
    var movePoints:Array<CGPoint>!
    var tile:UIView!
    var tile2:UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.backgrounds = Array<UIView>()
        playAnimation()
    }

    
    func playAnimation()
    {
        tile = UIView(frame: CGRectMake(10,200,30,30))
        print(tile.center)
        tile.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tile)
        
        self.movePoints = Array<CGPoint>()
        self.movePoints.append(CGPoint(x:100,y:215))
        self.movePoints.append(CGPoint(x:100,y:315))
        self.movePoints.append(CGPoint(x:25,y:315))
        self.movePoints.append(CGPoint(x:25,y:215))
        self.moveAnime()

    }

    
    func moveAnime(){
        
        self.moveFunc(0.5, rotateDuration: 0.5, point: self.movePoints[0], angle: 90)
    }
    
    var i = 0
    func moveFunc(moveDuration:Double, rotateDuration:Double, point:CGPoint, angle:Double){
        UIView.animateWithDuration(moveDuration, animations: {
            self.tile.center = point
//            self.tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.5,0.5))
            print(self.tile.frame)
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

    
    func turnRight(){
        UIView.animateWithDuration(0.5, animations: {
            self.tile.center = CGPoint(x: 100, y: 215)
            let a:CGFloat = CGFloat(90.0*(M_PI/180.0))
            self.tile.transform = CGAffineTransformMakeRotation(a)
//            self.tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.5,0.5))
            }, completion:{
                (finished:Bool) -> Void in
            }
        )
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
