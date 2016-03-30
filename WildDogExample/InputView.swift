//
//  InputView.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/29.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class InputView: UIView,UITextFieldDelegate {

    let Interval:CGFloat = 10
    let Btn_Height:CGFloat = 30
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    var textField:UITextField?
    var leftBtn:UIButton?
    var rightBtn:UIButton?
    var sendBtn:UIButton?
//    var inputLine:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backView:UIView = UIView(frame: CGRectMake(0,0,SCREEN_WIDTH,self.Btn_Height))
        backView.backgroundColor = UIColor.whiteColor()
//        self.backgroundColor = UIColor.whiteColor()
        
        self.leftBtn = UIButton(type:.Custom)
        self.leftBtn!.frame = CGRectMake(self.Interval, 0, 30, self.Btn_Height)
//        self.leftBtn!.backgroundColor = UIColor.whiteColor()
        self.leftBtn!.setTitle(")))", forState: UIControlState.Normal)
        self.BtnStyle(self.leftBtn!)
//        self.addSubview(self.leftBtn!)
        backView.addSubview(self.leftBtn!)
        
        self.textField = UITextField(frame: CGRectMake(self.leftBtn!.frame.origin.x+self.leftBtn!.frame.size.width+self.Interval,0,200,self.Btn_Height))
        self.textField!.borderStyle = UITextBorderStyle.None
        self.textField!.placeholder = "请输入:"
//        self.textField!.delegate = self
        self.textField!.clearButtonMode=UITextFieldViewMode.Always
//        self.addSubview(self.textField!)
        backView.addSubview(self.textField!)

        let inputLine:UIView = UIView(frame: CGRectMake(self.leftBtn!.frame.origin.x+self.leftBtn!.frame.size.width+self.Interval,self.Btn_Height,200,2))
        inputLine.backgroundColor = UIColor.greenColor()
        backView.addSubview(inputLine)
        
        self.rightBtn = UIButton(type:.Custom)
        self.rightBtn!.frame = CGRectMake(self.textField!.frame.origin.x+self.textField!.frame.size.width+self.Interval, 0, 30, self.Btn_Height)
//        self.rightBtn!.backgroundColor = UIColor.grayColor()
        self.rightBtn!.setTitle(":)", forState: UIControlState.Normal)
        self.BtnStyle(self.rightBtn!)
//        self.addSubview(self.rightBtn!)
        backView.addSubview(self.rightBtn!)

        self.sendBtn = UIButton(type:.Custom)
        self.sendBtn!.frame = CGRectMake(self.rightBtn!.frame.origin.x+self.rightBtn!.frame.size.width+self.Interval, 0, 60, self.Btn_Height)
//        self.sendBtn!.backgroundColor = UIColor.greenColor()
        self.sendBtn!.setTitle("Send", forState: UIControlState.Normal)
        self.BtnStyle(self.sendBtn!)
//        self.addSubview(self.sendBtn!)
        backView.addSubview(self.sendBtn!)

        self.addSubview(backView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func BtnStyle(btn:UIButton){
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = self.Btn_Height/2
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.blackColor().CGColor
    
    }

}
