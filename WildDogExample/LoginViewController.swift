//
//  LoginViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/1.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import Wilddog

class LoginViewController: UIViewController,UITextFieldDelegate {

    let Title_Width:CGFloat = 200
    let InputView_Height:CGFloat = 40
    var titleLabel:UILabel!
    var nameLabel:UILabel!
    var passwordLabel:UILabel!
    var nameTextField:UITextField!
    var passwordTextField:UITextField!
//    var nameTextField:ElasticTextField!
//    var passwordTextField:ElasticTextField!
    var loginBtn:UIButton!
    var registerBtn:UIButton!
    var registerView:RegisterView!
    var accountDic = Dictionary<String,String>()
    let WilddogURL = "https://yrq110.wilddogio.com"

    var versionLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        titleLabel = UILabel(frame: CGRectMake(SCREEN_WIDTH/2-Title_Width/2,100,Title_Width,30))
        titleLabel.text = "内部IM软件"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.systemFontOfSize(20.0)
        titleLabel.textColor = UIColor.purpleColor()
        self.view.addSubview(titleLabel)
        
        nameLabel = UILabel(frame: CGRectMake(50,self.getBottomY(titleLabel)+20,50,InputView_Height))
        nameLabel.text = "邮箱:"
        self.view.addSubview(nameLabel)
        
        nameTextField = UITextField(frame: CGRectMake(self.getRightX(nameLabel),self.getBottomY(titleLabel)+20,200,InputView_Height))
        nameTextField.placeholder = "请输入邮箱"
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nameTextField.delegate = self
        self.view.addSubview(nameTextField)
        
        passwordLabel = UILabel(frame: CGRectMake(50,self.getBottomY(nameLabel)+20,50,InputView_Height))
        passwordLabel.text = "密码:"
        self.view.addSubview(passwordLabel)
        
        passwordTextField = UITextField(frame: CGRectMake(self.getRightX(passwordLabel),self.getBottomY(nameLabel)+20,200,InputView_Height))
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.secureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(passwordTextField)
        
        loginBtn = UIButton(frame: CGRectMake(80,self.getBottomY(passwordLabel)+20,80,30))
        loginBtn.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 10.0
        loginBtn.layer.borderWidth = 1.0
        loginBtn.setTitle("Login", forState: UIControlState.Normal)
        loginBtn.addTarget(self, action: #selector(LoginViewController.loginAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        loginBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        self.view.addSubview(loginBtn)
        
        registerBtn = UIButton(frame: CGRectMake(self.getRightX(loginBtn)+40,self.getBottomY(passwordLabel)+20,80,30))
        registerBtn.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        registerBtn.layer.masksToBounds = true
        registerBtn.layer.cornerRadius = 10.0
        registerBtn.layer.borderWidth = 1.0
        registerBtn.setTitle("Register", forState: UIControlState.Normal)
        registerBtn.addTarget(self, action: "registerAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(registerBtn)
        
        versionLabel = UILabel(frame: CGRectMake(10,SCREEN_HEIGHT-30,50,30))
        versionLabel.text = "version:1.0"
        versionLabel.sizeToFit()
        self.view.addSubview(self.versionLabel)
        
        self.registerView = RegisterView(frame: CGRectMake(0,-280,0,0))
        self.registerView.registerBtn.addTarget(self, action: "signupUser:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(registerView)

    }

    func loginAction(sender:UIButton){
        
//        self.authUserLogin(nameTextField.text!, password:passwordTextField.text!)
        self.authUserLogin("111@111.com", password:"111")

    }
    
    func registerAction(sender:UIButton){
        
        self.registerView.frame = CGRectMake(0,100,SCREEN_WIDTH,280)
        let transition = CATransition()
        transition.duration = 1.0
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.registerView.layer.addAnimation(transition, forKey: nil)
        
    }
    
    func signupUser(sender:UIButton){
        
        let alertController = UIAlertController(title: "警告", message: "注册功能暂未开放", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        //something cool
    }
    
    func authUserLogin(user:String,password:String){
        let myRootRef = Wilddog(url:self.WilddogURL)
        myRootRef.authUser(user, password: password) {
            error, authData in
            if error != nil {
                print(error)
                let alertController = UIAlertController(title: "错误", message: "账号或密码错误", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                let mainVC = ViewController()
//                let User:Dictionary<String,String> = [
//                    "userId": authData.uid,
//                    "nickname":"yrq110"
//                ]
//                mainVC.transmitAccountMsg(self.nameTextField.text!)
                mainVC.transmitAccountMsg("111@111.com")

//                let myRootRef = Wilddog(url:self.WilddogURL)
//                let userRef = myRootRef.childByAppendingPath("UserAccount")
//                let User = [
//                    "1":["mail":"111@111.com","nickname":"dongwin"],
//                    "2":["mail":"222@222.com","nickname":"rizu"],
//                    "3":["mail":"333@333.com","nickname":"yrq110"],
//                    "4":["mail":"444@444.com","nickname":"dixxxy"],
//                    "5":["mail":"555@555.com","nickname":"ytime"]
//                    ]
//                userRef.setValue(User)
                
                let nvc=UINavigationController(rootViewController:mainVC)
                self.presentViewController(nvc, animated: true, completion: nil)
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == nameTextField {
            print("nameBeginEditing")
        }
        
        if textField == passwordTextField {
            print("passwordBeginEditing")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == nameTextField {
            textField.resignFirstResponder()
            return true;
        }else if textField == passwordTextField {
            textField.resignFirstResponder()
            return true;
        }
        return true;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func getBottomY(view:UIView) -> CGFloat {
        return view.frame.size.height+view.frame.origin.y
    }
    
    func getRightX(view:UIView) -> CGFloat {
        return view.frame.size.width+view.frame.origin.x
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
