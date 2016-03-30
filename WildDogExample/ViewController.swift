//
//  ViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/26.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import Wilddog

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    var bottomView:InputView!
    var textField:UITextField?
    var tableView:UITableView?
    var cellHeight = Dictionary<Int,CGFloat>()
    var chatMsgArray = Array<String>()
    var dic = Dictionary<String,Dictionary<String,String>>()
    var chatMsgDic = Dictionary<String,String>()
    let WilddogURL = "https://wild-dragon-40947.wilddogio.com"
    var newMessagesOnTop:Bool = true
    var initialAdds:Bool = true
    var userNickName:String = ""
    var userID:String = ""
//    var Usermsg = ["哈哈哈哈哈","你挺帅的","你也是","帅哥约吗","可以","豆腐脑吃什么的？","咸的","粽子吃什么的？","甜的"]
//    var chatAllDic = Dictionary<String,String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "聊天"
        
        self.MainViewInit()
        self.getTime()
        
//        var originFrame:CGRect
//        originFrame = self.view.frame;
//        var exam = myRootRef.childByAppendingPath("UserMsg")
//        let Usermsg = ["哈哈哈哈哈","你挺帅的","你也是","帅哥约吗","可以","豆腐脑吃什么的？","咸的","粽子吃什么的？","甜的"]
//        exam.setValue(Usermsg)
        
//        self.addEvent()
        
//        let myRootRef = Wilddog(url:self.WilddogURL)
//        let userRef = myRootRef.childByAppendingPath("UserMsg")
//    
//        userRef.observeEventType(.ChildAdded, withBlock: { snapshot in
//            
//            print("\(snapshot.childrenCount) is \(snapshot.value)")
//        
////            if (!self.initialAdds) {
//                    if(!self.chatMsgArray.contains(String(snapshot.value))){
//                        self.chatMsgArray.append(String(snapshot.value))
//                        self.tableView!.reloadData()
////                        print("\(self.initialAdds)")
//                        
//                    }
////                }
////            }
//            
//        })

//        userRef.observeEventType(.Value, withBlock: {
//            snapshot in
//            print("\(snapshot.childrenCount) obj : \(snapshot.hasChild("得得"))")
//            if(self.initialAdds){
//                //            self.Usermsg = snapshot.value as! Array
//    //            print("\(snapshot.value)")
//                print("\(self.initialAdds)")
//                self.chatMsgArray = snapshot.value as! Array
//                print("\(self.chatMsgArray)")
//                self.tableView!.reloadData()
//                self.initialAdds = false
//            }
//        })
        
        
        //导入数据

//        var userRef = myRootRef.childByAppendingPath("user")
//        var post1 = ["name":"yrq110","school":"bistu","age":"99"]
//        var post2 = ["name":"hah121","school":"tsinghua","age":"29"]
//        var post3 = ["name":"hue132","school":"peking","age":"12"]
//        var post4 = ["name":"qty421","school":"UCLA","age":"15"]
//        var users = ["post1":post1,"post2":post2,"post3":post3,"post4":post4]
//        userRef.setValue(users)
        
//        var post1Ref = userRef.childByAppendingPath("post1")
//        var msg = ["msg":["哈哈哈哈哈","你挺帅的","你也是","帅哥约吗","可以","豆腐脑吃什么的？","咸的","粽子吃什么的？","甜的"]]
//        post1Ref.updateChildValues(msg)
        
        //更新数据
//        var postRef = userRef.childByAppendingPath("post1")
//        var age = ["age":"15"]
//        postRef.updateChildValues(age)

        //添加具有随机ID数据头的数据
//        let post2 = ["name":"three stone","age":"20","sex":"female"]
//        let post2Ref = userRef.childByAutoId()
//        post2Ref.setValue(post2)
//        var postID = post2Ref.key
        
        // 写数据
//        myRootRef.setValue("It's so cool")
//        myRootRef.setValue("Hello World")


        // 读数据
//        myRootRef.observeEventType(.Value, withBlock: {
//            snapshot in
//            print("\(snapshot.key) -> \(snapshot.value)")
//        })
        
//        myRootRef.observeEventType(.ChildAdded, withBlock: { snapshot in
//            print(snapshot.value)
////            print(snapshot.value.objectForKey("age"))
////            print(snapshot.value.objectAtIndex(3))
//        })
        
//        myRootRef.observeEventType(.ChildChanged, withBlock: { snapshot in
//            let title = snapshot.value.objectForKey("name") as? String
//            print("The updated name is \(snapshot.value)")
//        })
        
        // 在数据的引用下，绑定一个 block 去读取数据
//        myRootRef.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
        
        //查询数据
//        userRef.queryOrderedByChild("age").observeEventType(.ChildAdded, withBlock: { snapshot in
////            print("\(String(snapshot.value.objectForKey("name")!))")
//            let string = String(snapshot.value.objectForKey("name")!)
//            self.chatMsgArray.append(string)
////            print("array count is \(self.chatMsgArray.count),last object is \(self.chatMsgArray.last!)")
//        })
        
        //用户认证
//        myRootRef.observeAuthEventWithBlock({ authData in
//            if authData != nil {
//                // 用户已认证
//                print(authData)
//            } else {
//                // 用户未认证
//                print("没认证啊帅哥")
//            }
//        })
        
        //用户登录
//        myRootRef.authUser("111@111.com", password: "111") {
//            error, authData in
//            if error != nil {
//                // 登录时发生错误
//                print("\(error)")
//            } else {
//                // 登录成功，返回authData数据
//                print("success")
//                // 登录的用户的唯一标识符
//                print(authData.uid)
//                
//                // 创建一个新的用户词典，其中包含用户信息
//                // 通过authData提供的参数
//                let newUser = [
//                    "provider": authData.provider,
//                    "displayName": authData.providerData["displayName"] as? NSString as? String]
//                print("\(newUser)")
//                // 创建一个“user”节点
////                myRootRef.childByAppendingPath("authMes").childByAppendingPath(authData.uid).setValue(newUser)
//            }
//        }
        
        // 当客户端连接中断时，写入一个字符串
//        myRootRef.onDisconnectSetValue("I disconnected!")

        //判断是否连接
//        var connectedRef = Wilddog(url:"https://wild-dragon-40947.wilddogio.com/.info/connected")
//        connectedRef.observeEventType(.Value, withBlock: { snapshot in
//            let connected = snapshot.value as? Bool
//            if connected != nil && connected! {
//                print("connected")
//            } else {
//                print("not connected")
//            }
//        })

//        print("\(postID)")
        
//        if self.authUserLogin("222@222.com", password: "222") == true {
//            print("bool is \(self.authUserLogin("222@222.com", password: "221"))")
//            self.addEvent()
//
//        }
        
        self.authUserLogin("555@555.com", password: "555")
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("keyboardWillChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        let leftItem = UIBarButtonItem(title:"通讯录",style:.Plain,target:self,action:"leftVC");
        self.navigationItem.leftBarButtonItem = leftItem;
        
        let rightItem = UIBarButtonItem(title:"画板",style:.Plain,target:self,action:"rightVC");
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    func leftVC() {
        let con_vc = ContactsViewController();
        self.navigationController!.pushViewController(con_vc,animated:false);
    }
    
    func rightVC() {
        let can_vc = CanvasViewController();
        self.navigationController!.pushViewController(can_vc,animated:true);
    }
    
    func keyboardWillChange(notif:NSNotification){
        let userInfo:NSDictionary = notif.userInfo!;
//        print("\(userInfo)")
        let keyBoardInfo: AnyObject? = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey);
        let beginY = keyBoardInfo?.CGRectValue.origin.y;
        let keyBoardInfo2: AnyObject? = userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey);
        let endY = keyBoardInfo2?.CGRectValue.origin.y;
//        let aTime = userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSTimeInterval
//        print("begin is \(beginY),end is \(endY)")
        var rect:CGRect = self.bottomView.frame
        if (beginY! - endY!)>0 {
            rect.origin.y -= (beginY! - endY!)
        }else{
            rect.origin.y += (endY! - beginY!)
        }
        self.bottomView.frame = rect
//        print("bottom.y is \(self.bottomView.frame.origin.y)")
    }
    
    func MainViewInit(){
//        self.textField = UITextField(frame: CGRectMake(20,self.view.frame.size.height-40,200,25))
//        self.textField!.borderStyle = UITextBorderStyle.RoundedRect
//        self.textField!.placeholder = "请输入:"
//        self.textField!.delegate = self
//        self.textField!.clearButtonMode=UITextFieldViewMode.Always
        
        self.tableView = UITableView(frame: CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-100) ,style: UITableViewStyle.Plain)
        self.tableView!.dataSource = self
        self.tableView!.delegate = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView!.separatorColor = UIColor.clearColor()
        self.view.addSubview(self.tableView!)
        
        self.bottomView = InputView(frame:CGRectMake(0,SCREEN_HEIGHT-40,SCREEN_WIDTH,32))
        self.bottomView.textField!.delegate = self
        self.view.addSubview(self.bottomView)
    }
    
    func authUserLogin(user:String,password:String){
        let myRootRef = Wilddog(url:self.WilddogURL)
        myRootRef.authUser(user, password: password) {
            error, authData in
            if error != nil {
            } else {
                
                self.userNickName = "yrq110"
                self.userID = authData.uid
                
                let newUser = [
                    "provider": authData.provider,
                    "userId": self.userID,
                    "nickname":self.userNickName
                ]
//                let authMes = myRootRef.childByAppendingPath("UserAccount")
//                let auth = authMes.childByAutoId()
//                auth.setValue(newUser)
                self.addEvent()
            }
        }
    }
    
    func addEvent() {
        let myRootRef = Wilddog(url:self.WilddogURL)
        let userRef = myRootRef.childByAppendingPath("UserMsg")
        userRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if (self.dic[String(snapshot.key)]) == nil {
                self.dic[String(snapshot.key)] = snapshot.value as! Dictionary
//                print("\(self.dic[String(snapshot.key)]!)")
            }
            
            if(!self.chatMsgArray.contains(String(snapshot.key))){
                self.chatMsgArray.append(String(snapshot.key))
                self.tableView!.reloadData()
                
                let item = self.tableView!.numberOfRowsInSection(0) - 1
                let lastItemIndex = NSIndexPath(forItem: item, inSection: 0)
                self.tableView!.scrollToRowAtIndexPath(lastItemIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            }
        })
    }
    
    // MARK: - TableViewFunc
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMsgArray.count
//        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
//        let cellIdentifier = "MessageViewCell"
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MessageViewCell
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as UITableViewCell
        let dateStr = self.chatMsgArray[indexPath.row]
//        cell.textLabel?.text = self.dic[dateStr]!["nickname"]!+":"+self.dic[dateStr]!["message"]!+"   time:"+dateStr
        let message:String = self.dic[dateStr]!["message"]!
        let nickName:String = self.dic[dateStr]!["nickname"]!
        if nickName == self.userNickName {
//            print("yes,msg is \(nickName) and \(message)")
            let cellIdentifier = "MyMsgViewCell"
            var cell:MyMsgViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MyMsgViewCell
            if (cell == nil) {
                cell = MyMsgViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
            }
            cell.msgLabel!.text = message
            cell.timeLabel!.text = dateStr
            cell.nickLabel!.text = nickName
            cell.msgLabel!.sizeToFit()
            var rect:CGRect = cell.msgLabel!.frame
            rect.size.width = 160.0;
            cell.msgLabel!.frame = rect
            self.adjustY(cell.timeLabel!, upLabel: cell.msgLabel!)
            self.adjustY(cell.bottomLine!, upLabel: cell.timeLabel!)
            self.cellHeight[indexPath.row] = cell.bottomLine!.frame.origin.y+cell.bottomLine!.frame.size.height+2.0
            cell.selectionStyle = UITableViewCellSelectionStyle.None
//            cell.setSelected(false, animated: false)
            return cell
        }else{
            let cellIdentifier = "MessageViewCell"
            var cell:MessageViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MessageViewCell
            if (cell == nil) {
                cell = MessageViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
            }
            cell.msgLabel!.text = message
            cell.timeLabel!.text = dateStr
            cell.nickLabel!.text = nickName
            cell.msgLabel!.sizeToFit()
            var rect2:CGRect = cell.msgLabel!.frame
            rect2.size.width = 160.0;
            cell.msgLabel!.frame = rect2
            self.adjustY(cell.timeLabel!, upLabel: cell.msgLabel!)
            self.adjustY(cell.bottomLine!, upLabel: cell.timeLabel!)
            
            self.cellHeight[indexPath.row] = cell.bottomLine!.frame.origin.y+cell.bottomLine!.frame.size.height+2.0
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
    }

    func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath) ->CGFloat{
//        print("height is \(indexPath.row),value is \(self.cellHeight[indexPath.row])")
        if self.cellHeight[indexPath.row] != nil{
            return self.cellHeight[indexPath.row]!
        }
        
        return 100
    }
    
    //滑动删除必须实现的方法
//    func tableView(tableView: UITableView,
//        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
//        forRowAtIndexPath indexPath: NSIndexPath) {
//            print("删除\(indexPath.row)")
//            let index = indexPath.row
//            self.chatMsgArray.removeAtIndex(index)
//            self.tableView?.deleteRowsAtIndexPaths([indexPath],
//                withRowAnimation: UITableViewRowAnimation.Top)
//    }
    
    //滑动删除
//    func tableView(tableView: UITableView,
//        editingStyleForRowAtIndexPath indexPath: NSIndexPath)
//        -> UITableViewCellEditingStyle {
//            return UITableViewCellEditingStyle.Delete
//    }
    
    //修改删除按钮的文字
//    func tableView(tableView: UITableView,
//        titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath)
//        -> String? {
//            return "删除"
//    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.bottomView.textField {
            print("beginEditing")
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == self.bottomView.textField {
            let str:String = self.bottomView.textField!.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
//            print("str_count is \(str.characters.count),text_count is \(self.textField!.text!.characters.count)")
            
            if !self.bottomView.textField!.text!.isEmpty && !str.isEmpty {
                print("\(!self.bottomView.textField!.text!.isEmpty)  \(self.bottomView.textField!.text!)")
                let myRootRef = Wilddog(url:self.WilddogURL)
                let exam = myRootRef.childByAppendingPath("UserMsg")
                let msg = ["ID":self.userID,"nickname":self.userNickName,"message":self.bottomView.textField!.text!]
                self.dic[self.getTime()] = msg
                exam.setValue(self.dic)
                textField.resignFirstResponder()
//                self.tableView!.reloadData()
                self.addEvent()
                
            }else{
                print("empty dude")
                textField.resignFirstResponder()
            }
            return true;
        }
        return true;
    }

//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        view.endEditing(true)
//    }
    
    // MARK: - GetSystemTime
    func getTime() -> String {
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss"
        let strNowTime = timeFormatter.stringFromDate(date) as String
//        print("time is \(strNowTime)")
        return strNowTime
    }
    
    // MARK: - AdjustOriginY
    func adjustY(downLabel:UIView,upLabel:UIView){
        downLabel.frame = CGRectMake(downLabel.frame.origin.x,upLabel.frame.origin.y+upLabel.frame.size.height+10, downLabel.frame.size.width, downLabel.frame.size.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

