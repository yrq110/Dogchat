//
//  SingleChatViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import Wilddog
class SingleChatViewController: UIViewController,
                                UITableViewDelegate,
                                UITableViewDataSource,
                                UITextFieldDelegate,
                                UIActionSheetDelegate{

    let myRootRef = Wilddog(url:WilddogURL)
    var msgPath:String!
    var tableView:UITableView?
    var cellHeight = Dictionary<Int,CGFloat>()
    var bottomView:InputView!
    var testText = Array<String>()
    var userID = ""
    var userNickname = ""
    var imageStr : String!

    var initLoad = true
    var chatMsgArray = Array<String>()
    var dic = Dictionary<String,Dictionary<String,String>>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        let backView = UIView(frame: self.view.frame)
        backView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(backView)
//        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        mainViewInit()
        
    }
    
    func getName(name:String,id:String,myName:String){
        
        self.title = name
        OtherName = name
        self.userID = id
        self.userNickname = myName
        initMessage()
//        refreshMessage()
//        self.tableView!.reloadData()
    }
    
    func mainViewInit(){
        
        tableView = UITableView(frame: CGRectMake(0, 70, SCREEN_WIDTH, 0.8291*SCREEN_HEIGHT+64) ,style: UITableViewStyle.Plain)
//        tableView = UITableView(frame: CGRectMake(0, 0.0959*SCREEN_HEIGHT-64, SCREEN_WIDTH, 0.8291*SCREEN_HEIGHT+64) ,style: UITableViewStyle.Plain)
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SingleChatMessageCell")
        tableView!.separatorColor = UIColor.clearColor()
        tableView!.backgroundColor = UIColor.clearColor()
        view.addSubview(tableView!)
        
        self.bottomView = InputView(frame:CGRectMake(0,0.925*SCREEN_HEIGHT,SCREEN_WIDTH,0.075*SCREEN_HEIGHT))
        self.bottomView.textField.delegate = self
        self.bottomView.leftBtn.addTarget(self, action: #selector(SingleChatViewController.leftAction(_:)), forControlEvents: .TouchUpInside)
        self.bottomView.sendBtn.addTarget(self, action: #selector(SingleChatViewController.sendAction(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.bottomView)
    
    }
    
    func leftAction(sender:AnyObject){
        let mapVC = MKMapViewController()
        print("msgPath is \(self.userNickname),\(self.msgPath)")
        if self.msgPath == nil{
            self.msgPath = "PrivateMsg"+"/"+self.userNickname+"/"+self.title!
        }
        mapVC.transValue(self.userID, userNickname: self.userNickname, msgPath: self.msgPath, isMyLocation: true, isOtherLocation: false)
        self.navigationController!.pushViewController(mapVC, animated: true)
    }
    
    func otherLocation(){
        let mapVC = MKMapViewController()
        mapVC.transValue(self.userID, userNickname: self.userNickname, msgPath: self.msgPath, isMyLocation: false, isOtherLocation: true)
        self.navigationController!.pushViewController(mapVC, animated: true)
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
                    i += 1
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
        
       print("init successed,\(self.msgPath)")
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
                    i += 1
                    if i == count {
                        userRef.removeAllObservers()
                        print("removed")
                        self.tableView!.reloadData()
                        self.initLoad = false
//                        self.refreshMessage()
                    }
                })
            }else {
                print("no message")
                //无路径时初始化存储路径，开始监听数据刷新
                self.msgPath = "PrivateMsg"+"/"+self.title!+"/"+self.userNickname
                self.initLoad = false
                self.refreshMessage()
            }
        })
        
        print("init successed,\(self.msgPath)")

    }
    
    
    func refreshMessage(){
        
        let userRef = myRootRef.childByAppendingPath(self.msgPath)
        userRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if !self.initLoad {
                print("childadded\n" + "key:\(snapshot.key)\n value:\(snapshot.value)")
//                print(snapshot.value)
                self.dic[snapshot.key] = snapshot.value as? Dictionary
                let message:String = self.dic[snapshot.key]!["message"]!
                let nickname:String = self.dic[snapshot.key]!["nickname"]!
                if message.hasPrefix("position:") {
                    if nickname != self.userNickname {
                        OtherName = nickname
                        let coordinate = message.componentsSeparatedByString(":")[1].componentsSeparatedByString(",")
//                        print("coordinate is \(coordinate)")
//                        print("longitude is \(coordinate[0]),latitude is \(coordinate[1])")
                        (OtherPostion["longitude"],OtherPostion["latitude"]) = (coordinate[0],coordinate[1])
                        let alertController = UIAlertController(title: "提示",
                            message: "对方开启了位置共享", preferredStyle: UIAlertControllerStyle.Alert)
                        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
                        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default,
                            handler: {
                                action in
                                self.otherLocation()
                        })
                        alertController.addAction(cancelAction)
                        alertController.addAction(okAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    }
                }else{
                    self.chatMsgArray.append(snapshot.key)
                    self.tableView!.reloadData()
                }
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
        
        if message.hasPrefix("image:") {
            imageStr = (message.substringFromIndex(message.startIndex.advancedBy(6)))
            cell.isImage = true
//        }else if message.hasPrefix("position:"){
//            cell.ispo
        }else{
            cell.isImage = false
        }
        
        if nickName == self.userNickname {
            cell.myCell()
        }else{
            cell.otherCell()
        }
        
        if !cell.isImage {
            cell.msgLabel!.text = message
            cell.msgLabel!.sizeToFit()
            let rect:CGRect = cell.msgLabel!.frame
            cell.msgLabel!.frame = rect
            
            var rect2:CGRect = cell.msgBackView!.frame
            rect2.size.height = rect.size.height + 20.0
            if rect.size.width < msgWidth {
                rect2.size.width = rect.size.width + 20.0
            }
            cell.msgBackView!.frame = rect2
            
            if cell.isMyCell && rect.size.width != msgWidth {
                cell.msgLabel!.frame.origin.x = SCREEN_WIDTH - cell.avatar!.yrq_width - cell.msgLabel!.yrq_width - 20
                cell.msgBackView!.frame.origin.x = SCREEN_WIDTH - cell.avatar!.yrq_width - cell.msgBackView!.yrq_width - 10
            }
            
            UITableViewCellSelectionStyle.None
            self.cellHeight[indexPath.row] = cell.msgBackView!.yrq_height+20.0
        } else {
            let imageData = NSData(base64EncodedString: imageStr, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            let image = UIImage(data: imageData!)
            cell.msgImageView!.frame.size = CGSizeMake(image!.size.width, image!.size.height)
            cell.msgImageView!.image = image
            if cell.isMyCell {
                cell.msgImageView!.frame.origin.x = SCREEN_WIDTH - cell.avatar!.yrq_width - cell.msgImageView!.yrq_width - 20
                print(cell.msgImageView!.frame)
            }
            
            UITableViewCellSelectionStyle.None
            self.cellHeight[indexPath.row] = cell.msgImageView!.yrq_height+20.0
        }
        
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
