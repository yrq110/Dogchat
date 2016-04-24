//
//  RegisterView.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/1.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class RegisterView: UIView,UITextFieldDelegate{
    
    let InputView_Height:CGFloat = 40
    var nicknameLabel:UILabel!
    var mailLabel:UILabel!
    var passwordLabel:UILabel!
    var nicknameTextField:UITextField!
    var mailTextField:UITextField!
    var passwordTextField:UITextField!
    var registerBtn:UIButton!
    var returnBtn:UIButton!
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.purpleColor().CGColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        self.backgroundColor = UIColor.whiteColor()
        
        nicknameLabel = UILabel(frame: CGRectMake(50,20,50,InputView_Height))
        nicknameLabel.text = "昵称:"
        self.addSubview(nicknameLabel)
        
        nicknameTextField = UITextField(frame: CGRectMake(self.getRightX(nicknameLabel)+10,20,200,InputView_Height))
        nicknameTextField.placeholder = "请输入昵称"
        nicknameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nicknameTextField.delegate = self
        self.addSubview(nicknameTextField)
        
        mailLabel = UILabel(frame: CGRectMake(50,self.getBottomY(nicknameLabel)+20,50,InputView_Height))
        mailLabel.text = "邮箱:"
        self.addSubview(mailLabel)
        
        mailTextField = UITextField(frame: CGRectMake(self.getRightX(mailLabel),self.getBottomY(nicknameLabel)+20,200,InputView_Height))
        mailTextField.placeholder = "请输入邮箱"
        mailTextField.borderStyle = UITextBorderStyle.RoundedRect
        mailTextField.delegate = self
        self.addSubview(mailTextField)
        
        passwordLabel = UILabel(frame: CGRectMake(50,self.getBottomY(mailLabel)+20,50,InputView_Height))
        passwordLabel.text = "密码:"
        self.addSubview(passwordLabel)
        
        passwordTextField = UITextField(frame: CGRectMake(self.getRightX(passwordLabel),self.getBottomY(mailLabel)+20,200,InputView_Height))
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.secureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.addSubview(passwordTextField)
        
        print("\(self.bounds.size.width)")
        registerBtn = UIButton(frame: CGRectMake(SCREEN_WIDTH/2-40,self.getBottomY(passwordLabel)+20,80,30))
        registerBtn.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        registerBtn.layer.masksToBounds = true
        registerBtn.layer.cornerRadius = 10.0
        registerBtn.layer.borderWidth = 1.0
        registerBtn.setTitle("注册", forState: UIControlState.Normal)
        self.addSubview(registerBtn)
        
        returnBtn = UIButton(frame: CGRectMake(SCREEN_WIDTH-80,280-40,60,30))
        returnBtn.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        returnBtn.layer.masksToBounds = true
        returnBtn.layer.cornerRadius = 10.0
        returnBtn.layer.borderWidth = 1.0
        returnBtn.setTitle("取消", forState: UIControlState.Normal)
        returnBtn.addTarget(self, action: "returnView:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(returnBtn)
        
    }
    
    func returnView(sender:UIButton){
        
        self.frame = CGRectMake(0,-280,SCREEN_WIDTH,280)
        let transition = CATransition()
        transition.duration = 1.0
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.layer.addAnimation(transition, forKey: nil)
    
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func getBottomY(view:UIView) -> CGFloat {
        return view.frame.size.height+view.frame.origin.y
    }
    
    func getRightX(view:UIView) -> CGFloat {
        return view.frame.size.width+view.frame.origin.x
    }
}
