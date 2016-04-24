//
//  ResponseToAnimeClass.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/6.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import Foundation

class TupleToAnime : UIView {
    
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    var dayColorArray:Array<UIColor>!
    var nightColorArray:Array<UIColor>!
    
    var sun:UIImageView!
    var moon:UIImageView!
    var scene:UIView!
    var dayBottomView:UIView!
    
    var colorNo = 0
    var seasonNo:Int = 0
    var daytimeNo:Int = 0
    var festivalNo:String = ""
    var weatherNo:Int = 0
    
    var cloud:UIView!
    var cloud_2:UIView!
    var cloudTimer:NSTimer!
    var cloudIsFired:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.seasonColorInit()
        self.sunAndMoonInit()
        self.cloudInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func tupleToAnime(tuple:(Int,Int,String,Int))
    {
        if cloudIsFired == false {
            cloudTimer.fire()
            cloudIsFired = true
        }
        seasonNo = tuple.0
        daytimeNo = tuple.1
        festivalNo = tuple.2
        weatherNo = tuple.3
        
        self.sunAndMoonWithTime(daytimeNo)

    }
    
    func seasonColorInit(){
        
        self.dayColorArray = Array<UIColor>()
        self.nightColorArray = Array<UIColor>()
        
        let springColor:UIColor = UIColor.init(red: 0, green: 255.0/255.0, blue: 127.0/255.0, alpha: 1)
        let summerColor:UIColor = UIColor.init(red: 255.0/255.0, green: 124.0/255.0, blue: 2.0/255.0, alpha: 1)
        let autumnColor:UIColor = UIColor.init(red: 255.0/255.0, green: 215.0/255.0, blue: 0, alpha: 1)
        let winterColor:UIColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 179.0/255.0, alpha: 1)
        self.dayColorArray.append(springColor)
        self.dayColorArray.append(summerColor)
        self.dayColorArray.append(autumnColor)
        self.dayColorArray.append(winterColor)
        
        let springColor2:UIColor = UIColor.init(red: 56.0/255.0, green: 94.0/255.0, blue: 15.0/255.0, alpha: 1)
        let summerColor2:UIColor = UIColor.init(red: 173.0/255.0, green: 85.0/255.0, blue: 3.0/255.0, alpha: 1)
        let autumnColor2:UIColor = UIColor.init(red: 237.0/255.0, green: 145.0/255.0, blue: 33.0/255.0, alpha: 1)
        let winterColor2:UIColor = UIColor.init(red: 175.0/255.0, green: 175.0/255.0, blue: 135.0/255.0, alpha: 1)
        self.nightColorArray.append(springColor2)
        self.nightColorArray.append(summerColor2)
        self.nightColorArray.append(autumnColor2)
        self.nightColorArray.append(winterColor2)
    }
    
    func sunAndMoonInit(){
        
        self.dayBottomView = UIView(frame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT))
        self.insertSubview(self.dayBottomView, atIndex: 0)
        
        self.moon = UIImageView(frame: CGRectMake(50,667,60,60))
        self.moon.image = UIImage(named: "moon.png")
        
        self.sun = UIImageView(frame: CGRectMake(50,667,60,60))
        self.sun.image = UIImage(named: "sun.png")
        
    }
    
    func flot(view:UIView){
        UIView.animateWithDuration(1.0, animations: {
            view.center = CGPoint(x:view.center.x,y:view.center.y+10.0)
            print("flow_1",view.center)
            }, completion:{
                (finished:Bool) -> Void in
                UIView.animateWithDuration(1.0, animations: {
                        view.center = CGPoint(x:view.center.x,y:view.center.y-10.0)
                        print("flow_2",view.center)
                    },completion:{
                        (finished:Bool) -> Void in
                        self.flot(view)
                    }
                )
            }
        )
    
    }
    
    
    func sunAndMoonWithTime(timeNo:Int) {
        
        switch timeNo {
        case 0...2:
            self.sunAndMoonTrans(self.sun, secondView: self.moon, yChange: 50, timeNo: timeNo, colorArray: self.dayColorArray)
        case 3,4:
            self.sunAndMoonTrans(self.moon, secondView: self.sun, yChange: -200, timeNo: timeNo, colorArray: self.nightColorArray)
        default:
            print("cool")
        }
    }
    
    func sunAndMoonTrans(firstView:UIView,secondView:UIView?,yChange:Int,timeNo:Int,colorArray:Array<UIColor>){
        firstView.frame = CGRectMake(50,667,60,60)
        UIView.animateWithDuration(3.0,
            animations: {
                if (secondView != nil) {
                    secondView!.removeFromSuperview()
                }
                self.addSubview(firstView)
                firstView.center = CGPoint(x: 50, y: timeNo*100+(yChange))
                self.dayBottomView.backgroundColor = colorArray[self.seasonNo]
            },completion: {
                (finished:Bool) -> Void in
//                self.flot(firstView)
        })
    
    }
    func cloudInit(){
        cloud = UIView(frame: CGRectMake(0,150,SCREEN_WIDTH,40))
        let cloudImageView = UIImageView(frame: CGRectMake(200,0,60,40))
        cloudImageView.image = UIImage(named: "cloud_1.png")
        cloud.addSubview(cloudImageView)
        self.addSubview(cloud)
        
        cloud_2 = UIView(frame: CGRectMake(SCREEN_WIDTH,150,SCREEN_WIDTH,40))
        let cloudImageView2 = UIImageView(frame: CGRectMake(200,0,80,40))
        cloudImageView2.image = UIImage(named: "cloud_2.png")
        cloud_2.addSubview(cloudImageView2)
        self.addSubview(cloud_2)
        
        cloudTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "cloudMovement", userInfo: nil, repeats: true)
    }
    
    func cloudMovement(){
        self.cloud.frame = CGRectMake(self.cloud.yrq_x-1, self.cloud.yrq_y, self.cloud.yrq_width, self.cloud.yrq_height)
        self.cloud_2.frame = CGRectMake(self.cloud_2.yrq_x-1, self.cloud_2.yrq_y, self.cloud_2.yrq_width, self.cloud_2.yrq_height)
        if self.cloud.yrq_x == -self.cloud.yrq_width {
            self.cloud.yrq_x = self.cloud.yrq_width
        }
        if self.cloud_2.yrq_x == -self.cloud_2.yrq_width {
            self.cloud_2.yrq_x = self.cloud_2.yrq_width
        }
    }
    
}