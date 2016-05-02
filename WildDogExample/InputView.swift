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

    
    var textField:UITextField!
    var leftBtn:UIButton!
    var rightBtn:UIButton!
    var sendBtn:UIButton!
//    var inputLine:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let Interval:CGFloat = 0.0267*SCREEN_WIDTH
        let Btn_Height:CGFloat = 0.045*SCREEN_HEIGHT
        
        let backView:UIView = UIView(frame: CGRectMake(0,0,SCREEN_WIDTH,0.075*SCREEN_HEIGHT))
        backView.backgroundColor = UIColor.whiteColor()
        
        leftBtn = UIButton(type:.Custom)
        leftBtn.frame = CGRectMake(Interval, Interval, 0.08*SCREEN_WIDTH, Btn_Height)
        leftBtn.setTitle(")))", forState: UIControlState.Normal)
        BtnStyle(leftBtn)
        backView.addSubview(leftBtn)
        
        textField = UITextField(frame: CGRectMake(leftBtn.frame.origin.x+leftBtn.frame.size.width+Interval, Interval, 0.533*SCREEN_WIDTH, Btn_Height))
        textField.borderStyle = UITextBorderStyle.None
        textField.placeholder = "请输入:"
        textField.clearButtonMode=UITextFieldViewMode.WhileEditing
        backView.addSubview(textField)

        let inputLine:UIView = UIView(frame: CGRectMake(leftBtn.frame.origin.x+leftBtn.frame.size.width+Interval,Btn_Height+Interval,0.533*SCREEN_WIDTH,2))
        inputLine.backgroundColor = UIColor.greenColor()
        backView.addSubview(inputLine)
        
        rightBtn = UIButton(type:.Custom)
        rightBtn.frame = CGRectMake(textField.frame.origin.x+textField.frame.size.width+Interval, Interval, 0.08*SCREEN_WIDTH, Btn_Height)
        rightBtn.setTitle(":)", forState: UIControlState.Normal)
        rightBtn.addTarget(self, action: "rightBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        BtnStyle(rightBtn)
        backView.addSubview(rightBtn)

        self.sendBtn = UIButton(type:.Custom)
        self.sendBtn.frame = CGRectMake(self.rightBtn.frame.origin.x+self.rightBtn.frame.size.width+Interval, Interval, 0.16*SCREEN_WIDTH, Btn_Height)
        self.sendBtn.setTitle("Send", forState: UIControlState.Normal)
        self.BtnStyle(self.sendBtn)
        backView.addSubview(self.sendBtn)

        self.addSubview(backView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("keyboardWillChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func rightBtnClick(sender:UIButton){
        print("oh")
    
    }
    
    func keyboardWillChange(notif:NSNotification){
        let userInfo:NSDictionary = notif.userInfo!;
        let keyBoardInfo: AnyObject? = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey);
        let beginY = keyBoardInfo?.CGRectValue.origin.y;
        let keyBoardInfo2: AnyObject? = userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey);
        let endY = keyBoardInfo2?.CGRectValue.origin.y;
        var rect:CGRect = self.frame
        //        var tableRect = self.tableView!.frame
        if (beginY! - endY!)>0 {
            rect.origin.y -= (beginY! - endY!)
            //            tableRect.size.height -= (beginY! - endY!)
        }else{
            rect.origin.y += (endY! - beginY!)
            //            tableRect.size.height += (endY! - beginY!)
        }
        self.frame = rect
        //        self.tableView!.frame = tableRect
        //        self.tableView!.scrollToRowAtIndexPath(NSIndexPath(forRow: self.chatMsgArray.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func BtnStyle(btn:UIButton){
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = btn.frame.size.height/2
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.blackColor().CGColor
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    


}
