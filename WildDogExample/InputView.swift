//
//  InputView.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/29.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class InputView: UIView,UITextFieldDelegate {

   
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

    
    var textField:UITextField?
    var leftBtn:UIButton?
    var rightBtn:UIButton?
    var sendBtn:UIButton?
//    var inputLine:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let Interval:CGFloat = 0.0267*SCREEN_WIDTH
        let Btn_Height:CGFloat = 0.045*SCREEN_HEIGHT
        
        let backView:UIView = UIView(frame: CGRectMake(0,0,SCREEN_WIDTH,0.075*SCREEN_HEIGHT))
        backView.backgroundColor = UIColor.whiteColor()
        
        self.leftBtn = UIButton(type:.Custom)
        self.leftBtn!.frame = CGRectMake(Interval, Interval, 0.08*SCREEN_WIDTH, Btn_Height)
        self.leftBtn!.setTitle(")))", forState: UIControlState.Normal)
        self.BtnStyle(self.leftBtn!)
        backView.addSubview(self.leftBtn!)
        
        self.textField = UITextField(frame: CGRectMake(self.leftBtn!.frame.origin.x+self.leftBtn!.frame.size.width+Interval, Interval, 0.533*SCREEN_WIDTH, Btn_Height))
        self.textField!.borderStyle = UITextBorderStyle.None
        self.textField!.placeholder = "请输入:"
        self.textField!.clearButtonMode=UITextFieldViewMode.WhileEditing
        backView.addSubview(self.textField!)

        let inputLine:UIView = UIView(frame: CGRectMake(self.leftBtn!.frame.origin.x+self.leftBtn!.frame.size.width+Interval,Btn_Height+Interval,0.533*SCREEN_WIDTH,2))
        inputLine.backgroundColor = UIColor.greenColor()
        backView.addSubview(inputLine)
        
        self.rightBtn = UIButton(type:.Custom)
        self.rightBtn!.frame = CGRectMake(self.textField!.frame.origin.x+self.textField!.frame.size.width+Interval, Interval, 0.08*SCREEN_WIDTH, Btn_Height)
        self.rightBtn!.setTitle(":)", forState: UIControlState.Normal)
        self.BtnStyle(self.rightBtn!)
        backView.addSubview(self.rightBtn!)

        self.sendBtn = UIButton(type:.Custom)
        self.sendBtn!.frame = CGRectMake(self.rightBtn!.frame.origin.x+self.rightBtn!.frame.size.width+Interval, Interval, 0.16*SCREEN_WIDTH, Btn_Height)
        self.sendBtn!.setTitle("Send", forState: UIControlState.Normal)
        self.BtnStyle(self.sendBtn!)
        backView.addSubview(self.sendBtn!)

        self.addSubview(backView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func BtnStyle(btn:UIButton){
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = btn.frame.size.height/2
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.blackColor().CGColor
    
    }

}
