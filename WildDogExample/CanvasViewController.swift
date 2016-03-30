//
//  CanvasViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/30.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
class CanvasViewController: UIViewController {
    
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    var viewIndexNumber:NSInteger = 0
    var firstTangramView:FirstTangramView = FirstTangramView()
    var secondTangramView:SecondTangramView = SecondTangramView()
    var thirdTangramView:ThirdTangramView = ThirdTangramView()
    var forthTangramView:ForthTangramView = ForthTangramView()
    var fifthTangramView:FifthTangramView = FifthTangramView()
    var sixthTangramView:SixthTangramView = SixthTangramView()
    var seventhTangramView:SeventhTangramView = SeventhTangramView()

    override func viewWillAppear(animated: Bool) {

//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.firstTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.secondTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.thirdTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.forthTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.fifthTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.sixthTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.seventhTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分享"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.firstTangramView = FirstTangramView(frame: self.view.bounds)
        self.firstTangramView.userInteractionEnabled = true
        let firstTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "firstViewTouch")
        self.firstTangramView .addGestureRecognizer(firstTap)
        self.view.addSubview(self.firstTangramView)
        
        self.secondTangramView = SecondTangramView(frame: self.view.bounds)
        self.secondTangramView.userInteractionEnabled = true
        let secondTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "secondViewTouch")
        self.secondTangramView .addGestureRecognizer(secondTap)
        self.view.addSubview(self.secondTangramView)
        
        self.thirdTangramView = ThirdTangramView(frame: self.view.bounds)
        self.thirdTangramView.userInteractionEnabled = true
        let thirdTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "thirdViewTouch")
        self.thirdTangramView .addGestureRecognizer(thirdTap)
        self.view.addSubview(self.thirdTangramView)
        
        self.forthTangramView = ForthTangramView(frame: self.view.bounds)
        self.forthTangramView.userInteractionEnabled = true
        let forthTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "forthViewTouch")
        self.forthTangramView .addGestureRecognizer(forthTap)
        self.view.addSubview(self.forthTangramView)
        
        self.fifthTangramView = FifthTangramView(frame: self.view.bounds)
        self.fifthTangramView.userInteractionEnabled = true
        let fifthTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "fifthViewTouch")
        self.fifthTangramView .addGestureRecognizer(fifthTap)
        self.view.addSubview(self.fifthTangramView)
        
        self.sixthTangramView = SixthTangramView(frame: self.view.bounds)
        self.sixthTangramView.userInteractionEnabled = true
        let sixTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "sixthViewTouch")
        self.sixthTangramView .addGestureRecognizer(sixTap)
        self.view.addSubview(self.sixthTangramView)
        
        self.seventhTangramView = SeventhTangramView(frame: self.view.bounds)
        self.seventhTangramView.userInteractionEnabled = true
        let sevenTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "seventhViewTouch")
        self.seventhTangramView .addGestureRecognizer(sevenTap)
        self.view.addSubview(self.seventhTangramView)

        self.linearIn()
        
    }

    func firstViewTouch(){
        print("touch first view")
        self.linearOutIndex(1, view: self.firstTangramView)
    }
    func secondViewTouch(){
        print("touch second view")
        self.linearOutIndex(2, view: self.secondTangramView)
    }
    func thirdViewTouch(){
        print("touch third view")
        self.linearOutIndex(3, view: self.thirdTangramView)
    }
    func forthViewTouch(){
        print("touch forth view")
        self.linearOutIndex(4, view: self.forthTangramView)
    }
    func fifthViewTouch(){
        print("touch fifth view")
        self.linearOutIndex(5, view: self.fifthTangramView)
    }
    func sixthViewTouch(){
        print("touch sixth view")
        self.linearOutIndex(6, view: self.sixthTangramView)
    }
    func seventhViewTouch(){
        print("touch first view")
        self.linearOutIndex(7, view: self.seventhTangramView)
    }
    
    func linearIn(){
        self.firstTangramView.frame = CGRectMake(-SCREEN_WIDTH, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.secondTangramView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.thirdTangramView.frame = CGRectMake(-2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.forthTangramView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.fifthTangramView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.sixthTangramView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.seventhTangramView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        UIView.animateWithDuration(2.0, animations:self.linearInAnimationMethod)
    
    }
    
    func linearInAnimationMethod(){
        self.firstTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.secondTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.thirdTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.forthTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.fifthTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.sixthTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.seventhTangramView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    }
    
    func linearOutIndex(index:NSInteger,view:UIView){
        self.view.backgroundColor = view.backgroundColor
        self.viewIndexNumber = index
        UIView.animateWithDuration(1.0, animations: self.linearOutIndexAnimationMethod, completion:{
            finished in
            self.linearOutIndexAnimationFinished()
            })
        

    }
    
    func linearOutIndexAnimationMethod(){
        
        if self.viewIndexNumber != 1{
            self.firstTangramView.frame = CGRectMake(-SCREEN_WIDTH, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
        if self.viewIndexNumber != 2{
            self.secondTangramView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
        if self.viewIndexNumber != 3{
            self.thirdTangramView.frame = CGRectMake(-2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
        if self.viewIndexNumber != 4{
            self.forthTangramView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
        if self.viewIndexNumber != 5{
            self.fifthTangramView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
        if self.viewIndexNumber != 6{
            self.sixthTangramView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
        if self.viewIndexNumber != 7{
            self.seventhTangramView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
    
    }
    
    
    func linearOutIndexAnimationFinished(){
        let detailVC:DetailViewController = DetailViewController()
        detailVC.backgroundColor = view.backgroundColor;
        detailVC.title = "Example";
        self.navigationController!.pushViewController(detailVC, animated: true)
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
