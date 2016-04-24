//
//  BoardViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/31.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, HolderViewDelegate {

    var holderView = HolderView(frame: CGRectZero)
    var boobView = ButtonBoobView(frame: CGRectZero)
    var button : UIButton!
    var cancelButton : UIButton!
    let boxSize: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        buttonInit()
        cancelButtonInit()
        //    addHolderView()
    }
    func buttonInit() {
        button = UIButton(frame: CGRectMake(view.bounds.width / 2 - boxSize / 2,
            view.bounds.height / 2 - boxSize / 2 - 5 ,boxSize,boxSize - 25))
        button.backgroundColor = UIColor.redColor()
        button.setTitle("Click", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.view.addSubview(button)
    }
    
    func buttonAction(sender: UIButton) {
        
        addBoobView()
    }
    
    func cancelButtonInit() {
        
        cancelButton = UIButton(frame: CGRectMake(view.bounds.width / 2 - boxSize / 2,
            button.frame.origin.y + button.frame.size.height + 10,boxSize,boxSize - 25))
        cancelButton.backgroundColor = UIColor.redColor()
        cancelButton.setTitle("remove", forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: "cancelButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.view.addSubview(cancelButton)
        
    }
    
    func cancelButtonAction(sender: UIButton) {
        
        boobView.removeFromSuperview()
        
    }
    func addBoobView() {
        boobView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
            y: view.bounds.height / 2 - boxSize / 2  ,
            width: boxSize,
            height: boxSize - 30)
        boobView.parentFrame = view.frame
        view.addSubview(boobView)
        
        boobView.addOval()
    }
    
    func addHolderView() {
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
            y: view.bounds.height / 2 - boxSize / 2,
            width: boxSize,
            height: boxSize/2)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        view.addSubview(holderView)
        
        holderView.addOval()
    }
    
    func animateLabel() {
        // 1
        holderView.removeFromSuperview()
        view.backgroundColor = Colors.blue
        
        // 2
        var label: UILabel = UILabel(frame: view.frame)
        label.textColor = Colors.white
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 170.0)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Ytime"
        label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25)
        view.addSubview(label)
        
        // 3
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut,
            animations: ({
                label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0)
            }), completion: { finished in
                self.addButton()
        })
    }
    
    func addButton() {
        let button = UIButton()
        button.frame = CGRectMake(0.0, 0.0, view.bounds.width, view.bounds.height)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func buttonPressed(sender: UIButton!) {
        view.backgroundColor = Colors.white
        view.subviews.map({ $0.removeFromSuperview() })
        holderView = HolderView(frame: CGRectZero)
        addHolderView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
