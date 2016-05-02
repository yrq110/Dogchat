//
//  SingleChatViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import Wilddog
class SingleChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    let myRootRef = Wilddog(url:WilddogURL)
    var msgPath:String!
    var tableView:UITableView?
    var cellHeight = Dictionary<Int,CGFloat>()
    var bottomView:InputView!
    var testText = Array<String>()
    var userID = ""
    var userNickname = ""
    var initLoad = true
    var chatMsgArray = Array<String>()
    var dic = Dictionary<String,Dictionary<String,String>>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        mainViewInit()
        
    }
    
    func getName(name:String,id:String,myName:String){
        
        self.title = name
        self.userID = id
        self.userNickname = myName
        initMessage()
//        refreshMessage()
//        self.tableView!.reloadData()
    }
    
    func mainViewInit(){
        
        tableView = UITableView(frame: CGRectMake(0, 0.0959*SCREEN_HEIGHT-64, SCREEN_WIDTH, 0.8291*SCREEN_HEIGHT+64) ,style: UITableViewStyle.Plain)
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SingleChatMessageCell")
        tableView!.separatorColor = UIColor.clearColor()
        tableView!.backgroundColor = UIColor.clearColor()
        view.addSubview(tableView!)
        
        self.bottomView = InputView(frame:CGRectMake(0,0.925*SCREEN_HEIGHT,SCREEN_WIDTH,0.075*SCREEN_HEIGHT))
        self.bottomView.textField!.delegate = self
        self.bottomView.sendBtn!.addTarget(self, action: "sendAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.bottomView)
    
    }
    
    func initMessage(){
//        let myRootRef = Wilddog(url:WilddogURL)
        let userRef = myRootRef.childByAppendingPath("PrivateMsg"+"/"+self.userNickname+"/"+self.title!)
        userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value != nil{
                print("Get msg!")
//                self.initLoad = false
                self.msgPath = "PrivateMsg"+"/"+self.userNickname+"/"+self.title!
                self.refreshMessage()

                let count = snapshot.value.count
                var i = 0
                userRef.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: { snapshot in
                    self.dic[snapshot.key] = snapshot.value as? Dictionary
                    self.chatMsgArray.append(snapshot.key)
                    i++
                    if i == count {
                        userRef.removeAllObservers()
                        print("removed")
                        self.tableView!.reloadData()
                        self.initLoad = false
//                        self.refreshMessage()
                    }
                })
            }else {
                self.initMessageAgain()
            }
        })
        
       
    }
    
    func initMessageAgain(){

        let userRef = myRootRef.childByAppendingPath("PrivateMsg"+"/"+self.title!+"/"+self.userNickname)
        userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value != nil{
                print("Get msg!")
//                self.initLoad = false
                self.msgPath = "PrivateMsg"+"/"+self.title!+"/"+self.userNickname
                self.refreshMessage()
                
                let count = snapshot.value.count
                var i = 0
                userRef.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: { snapshot in
                    self.dic[snapshot.key] = snapshot.value as? Dictionary
                    self.chatMsgArray.append(snapshot.key)
                    i++
                    if i == count {
                        userRef.removeAllObservers()
                        print("removed")
                        self.tableView!.reloadData()
                        self.initLoad = false
                        
//                        self.refreshMessage()
                    }
                })
            }else {
                print("nil")
            }
        })
    }
    
    
    func refreshMessage(){
//        if self.msgPath == nil {
//            print("nil msgPath")
//        } else {
        let userRef = myRootRef.childByAppendingPath(self.msgPath)
        userRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if !self.initLoad {
                print("childadded")
                self.dic[snapshot.key] = snapshot.value as? Dictionary
                self.chatMsgArray.append(snapshot.key)
                self.tableView!.reloadData()
            }
            
        })
//        }
    }
    
    func sendAction(sender:UIButton){
        let str:String = self.bottomView.textField!.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if !self.bottomView.textField!.text!.isEmpty && !str.isEmpty {
            //            print("\(!self.bottomView.textField!.text!.isEmpty)  \(self.bottomView.textField!.text!)")
            let myRootRef = Wilddog(url:WilddogURL)
            let msgRef = myRootRef.childByAppendingPath(self.msgPath)
            let Ref = msgRef.childByAutoId()
            let time = Time()
            let msg = ["ID":self.userID,"nickname":self.userNickname,"message":self.bottomView.textField!.text!,"time":time.getTime()]
            Ref.setValue(msg)
            print(msg)
        }else{
            //            print("empty dude")
        }
        self.bottomView.textField!.resignFirstResponder()
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.chatMsgArray != nil {
        return self.chatMsgArray.count
//        }
//        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        let cellIdentifier = "SingleChatMessageCell"
        var cell:SingleChatMessageCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SingleChatMessageCell
        if (cell == nil) {
            cell = SingleChatMessageCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
        }else{
            while cell.contentView.subviews.last != nil{
                cell.contentView.subviews.last!.removeFromSuperview()
            }
        }
        
        let key = self.chatMsgArray[indexPath.row]
        let message:String = self.dic[key]!["message"]!
        let nickName:String = self.dic[key]!["nickname"]!
        
        if nickName == self.userNickname {
            cell.myCell()
        }else{
            cell.otherCell()
        }
        
        cell.msgLabel!.text = message
        cell.msgLabel!.sizeToFit()
        var rect:CGRect = cell.msgLabel!.frame
        rect.size.width = msgWidth
        cell.msgLabel!.frame = rect
        
        var rect2:CGRect = cell.msgBackView!.frame
        rect2.size.height = rect.size.height + 20.0
        cell.msgBackView!.frame = rect2
        
        self.cellHeight[indexPath.row] = cell.msgBackView!.yrq_height+10.0
        return cell
    }
    
    func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath) ->CGFloat{
        if self.cellHeight[indexPath.row] != nil{
            return self.cellHeight[indexPath.row]!
        }
        return 30
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == self.bottomView.textField {
            textField.resignFirstResponder()
            return true;
        }
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
