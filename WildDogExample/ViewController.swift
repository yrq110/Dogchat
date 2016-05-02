//
//  ViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/26.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import Wilddog

class ViewController: UIViewController,
                    UITableViewDelegate,
                    UITableViewDataSource,
                    UITextFieldDelegate,
                    UIImagePickerControllerDelegate,
                    UINavigationControllerDelegate {
    
    //MARK: - let and var
    let selloColor = UIColor.init(white: 1.0, alpha: 0.7)
    let WilddogURL = "https://yrq.wilddogio.com"
    let colorArray = [UIColor.blueColor(),UIColor.greenColor(),UIColor.yellowColor(),UIColor.redColor(),UIColor.purpleColor()]
    var bottomView:InputView!
    var tableView:UITableView?
    var cellHeight = Dictionary<Int,CGFloat>()
    var chatMsgArray = Array<String>()
    var dic = Dictionary<String,Dictionary<String,String>>()
    var newMessagesOnTop = true
    var initialAdds = true
    var isAddsOn = false
    var userMail:String!
    var userNickName:String!
    var imageStr : String!
    var thumbnailImageStr : String!
    var userID:String!
    var endCellRow = 0
    var isFirstLoad = true
    var observerHandle:WilddogHandle!
    
    var timeAnime = TupleToAnime()
    let parse = Parse()
    var loadingView = LoadingAnimeView()
    //MARK: - ViewLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.title = "Lobby"
        
        print("height:\(SCREEN_HEIGHT),width:\(SCREEN_WIDTH)")
        
        self.view.addSubview(timeAnime)
        
        loadingView.frame.origin = CGPointMake(SCREEN_WIDTH/2-loadingView.yrq_width/2, SCREEN_HEIGHT/2-loadingView.yrq_height/2)
        self.view.addSubview(loadingView)
        
        self.MainViewInit()
        
        self.userMail = "444@444.com"
        self.authUserLogin(self.userMail, password: "444")
        

//        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("keyboardWillChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        let leftItem = UIBarButtonItem(title:"Contacts",style:.Plain,target:self,action:"leftVC");
        self.navigationItem.leftBarButtonItem = leftItem;
        
        let rightItem = UIBarButtonItem(title:"Other",style:.Plain,target:self,action:"rightVC");
        navigationItem.rightBarButtonItem = rightItem;
        
    }
    
    //MARK: OtherVC
    var transContacts = 0
    func leftVC() {
        let con_vc = ContactsViewController()
        con_vc.transmitAccountMsg(self.userMail,id:self.userID,nickname:self.userNickName)
        self.navigationController!.pushViewController(con_vc,animated:true);
    }
    
    func rightVC() {
        let can_vc = CanvasViewController()
        self.navigationController!.pushViewController(can_vc,animated:true);
    }
    
    //MARK: KeyBoardChange
//    func keyboardWillChange(notif:NSNotification){
//        let userInfo:NSDictionary = notif.userInfo!;
//        let keyBoardInfo: AnyObject? = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey);
//        let beginY = keyBoardInfo?.CGRectValue.origin.y;
//        let keyBoardInfo2: AnyObject? = userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey);
//        let endY = keyBoardInfo2?.CGRectValue.origin.y;
//        var rect:CGRect = self.bottomView.frame
////        var tableRect = self.tableView!.frame
//        if (beginY! - endY!)>0 {
//            rect.origin.y -= (beginY! - endY!)
////            tableRect.size.height -= (beginY! - endY!)
//        }else{
//            rect.origin.y += (endY! - beginY!)
////            tableRect.size.height += (endY! - beginY!)
//        }
//        self.bottomView.frame = rect
////        self.tableView!.frame = tableRect
////        self.tableView!.scrollToRowAtIndexPath(NSIndexPath(forRow: self.chatMsgArray.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
//    }
    
    func MainViewInit(){
        
        self.tableView = UITableView(frame: CGRectMake(0, 0.0959*SCREEN_HEIGHT, SCREEN_WIDTH, 0.8291*SCREEN_HEIGHT) ,style: UITableViewStyle.Plain)
        self.tableView!.dataSource = self
        self.tableView!.delegate = self
//        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SingleChatMessageCell")
        self.tableView!.separatorColor = UIColor.clearColor()
        self.tableView!.backgroundColor = UIColor.clearColor()
//        self.tableView!.bounces = false
        self.view.addSubview(self.tableView!)
        
        self.bottomView = InputView(frame:CGRectMake(0,0.925*SCREEN_HEIGHT,SCREEN_WIDTH,0.075*SCREEN_HEIGHT))
        self.bottomView.textField.delegate = self
        self.bottomView.sendBtn.addTarget(self, action: "sendAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.bottomView.rightBtn.addTarget(self, action: "rightBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.bottomView)
        
    }
    
    func rightBtnClick(sender:UIButton){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.showViewController(imagePicker, sender: self)
    }
    
    //MARK: ImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            print("select photo")
            let newImageThumbnail = imageCompressForWidth(image, targetWidth: 100)
            let data = UIImageJPEGRepresentation(newImageThumbnail, 1.0)!
            thumbnailImageStr = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            let str = "image:" + thumbnailImageStr
            
            let myRootRef = Wilddog(url:self.WilddogURL)
            let msgRef = myRootRef.childByAppendingPath("UserMsg")
            msgRef.removeObserverWithHandle(self.observerHandle)
            let Ref = msgRef.childByAutoId()
            let msg = ["ID":self.userID,"nickname":self.userNickName,"message":str,"time":self.getTime()]
            Ref.setValue(msg)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func decodingPicture(imageStr:String,origin:CGPoint,imageView:UIImageView){
        let imageData = NSData(base64EncodedString: imageStr, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let image = UIImage(data: imageData!)
        UIView.animateWithDuration(1.0, animations: {
            imageView.image = image
            imageView.frame.origin = CGPointMake(origin.x, origin.y)
            imageView.frame.size = CGSizeMake(image!.size.width, image!.size.height)
        })
        
        
    }
    func imageCompressForWidth(sourceImage:UIImage ,targetWidth:CGFloat) -> UIImage {
        let imageSize = sourceImage.size
        let width = imageSize.width
        let height = imageSize.height
        let targetHeight = (targetWidth / width) * height
        UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight))
        sourceImage.drawInRect(CGRectMake(0, 0, targetWidth, targetHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //MARK: Login & Observer
    func authUserLogin(user:String,password:String){
        let myRootRef = Wilddog(url:self.WilddogURL)
        myRootRef.authUser(user, password: password) {
            error, authData in
            if error != nil {
            } else {
                let accountRef = myRootRef.childByAppendingPath("UserAccount")
                accountRef.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: { snapshot in
                        let nickname = snapshot.value["nickname"] as! String
                        let mail = snapshot.value["mail"] as! String
                        if mail == self.userMail{
                            self.userNickName = nickname
                            self.userID = authData.uid
                            self.msgInitialAdd()
                            self.addEvent()
                        }
                })
                
            }
        }
    }

    func msgInitialAdd(){
        let myRootRef = Wilddog(url:self.WilddogURL)
        let userRef = myRootRef.childByAppendingPath("UserMsg")
        userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            let count = snapshot.value.count
            var i = 0
            self.observerHandle = userRef.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: { snapshot in
                if snapshot.value != nil{
//                    print("observeInitAdd")
                    self.dic[snapshot.key] = snapshot.value as? Dictionary
//                    print(self.dic[snapshot.key]!["time"]!)
//                    print(self.parse.parseStr(self.dic[snapshot.key]!["time"]!))
                    self.chatMsgArray.append(snapshot.key)
                    i++
                    if i == count {
                        self.loadingView.hidden = true
                        self.timeAnime.tupleToAnime(self.parse.parseStr(self.dic[snapshot.key]!["time"]!))
                        userRef.removeAllObservers()
//                        print("removed")
                        self.initialAdds = false
                        self.tableView!.reloadData()
                    }
                }
            })
        })
    }
    
    func addEvent() {
        let myRootRef = Wilddog(url:self.WilddogURL)
        let userRef = myRootRef.childByAppendingPath("UserMsg")
        
        userRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if !self.initialAdds {
                print("childadded")
                self.dic[snapshot.key] = snapshot.value as? Dictionary
                self.chatMsgArray.append(snapshot.key)
//                self.timeAnime.tupleToAnime(self.parse.parseStr(self.dic[snapshot.key]!["time"]!))
//                print(self.dic[snapshot.key]!["time"]!)
//                print(self.parse.parseStr(self.dic[snapshot.key]!["time"]!))
                
                self.tableView!.reloadData()
//                self.tableView!.scrollToRowAtIndexPath(NSIndexPath(forRow: self.chatMsgArray.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            }
            
        })
    }
    
    func transmitAccountMsg(mail:String){
        let myRootRef = Wilddog(url:self.WilddogURL)
        let accountRef = myRootRef.childByAppendingPath("UserAccount")
        accountRef.queryOrderedByChild("mail").observeEventType(.Value, withBlock: { snapshot in
            for var i=0 ; i<Int(snapshot.childrenCount) ; ++i {
                if mail == (snapshot.value[i]!["mail"] as! String){
                    self.userNickName = snapshot.value[i]["nickname"] as! String
//                    print("get it:\(snapshot.value[i]["nickname"] as! String)")
                    self.addEvent()
                }
            }
        })
    }
    
    // MARK: - TableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMsgArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
//        if isFirstLoad {
//            endCellRow = indexPath.row
//            isFirstLoad = false
//            print("cellRowCount:",endCellRow)
//        }else{
//            if indexPath.row < endCellRow {
//                endCellRow--
//                print("cellRowCount:",endCellRow)
//                UIView.animateWithDuration(0.1, animations:
//                    {self.timeAnime.tupleToAnime(self.parse.parseStr(self.chatMsgArray[self.endCellRow]))}
//                )
//
//            }else{
//                endCellRow++
//                print("cellRowCount:",endCellRow)
//                UIView.animateWithDuration(0.1, animations:
//                    {self.timeAnime.tupleToAnime(self.parse.parseStr(self.chatMsgArray[self.endCellRow]))}
//                )
//            }
//        
//        }
        let cellIdentifier = "SingleChatMessageCell"
        var cell:SingleChatMessageCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SingleChatMessageCell
//        var cell = tableView.cellForRowAtIndexPath(indexPath)
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
        }else{
            cell.isImage = false
        }
        
        if nickName == self.userNickName {
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
        }else{
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
    
    //MARK: - TextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.bottomView.textField {
//            print("beginEditing")
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == self.bottomView.textField {
            textField.resignFirstResponder()
            return true
        }
        return true
    }

    func sendAction(sender:UIButton){
        
        let str:String = self.bottomView.textField!.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if !self.bottomView.textField!.text!.isEmpty && !str.isEmpty {
//            print("\(!self.bottomView.textField!.text!.isEmpty)  \(self.bottomView.textField!.text!)")
            let myRootRef = Wilddog(url:self.WilddogURL)
            let msgRef = myRootRef.childByAppendingPath("UserMsg")
            msgRef.removeObserverWithHandle(self.observerHandle)
            let Ref = msgRef.childByAutoId()
            let msg = ["ID":self.userID,"nickname":self.userNickName,"message":self.bottomView.textField!.text!,"time":self.getTime()]
            Ref.setValue(msg)
            print("addMessage")
        }else{
//            print("empty dude")
        }
        self.bottomView.textField!.resignFirstResponder()
    }
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        view.endEditing(true)
//    }
    
    // MARK: - GetSystemTime
    func getTime() -> String {
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd.HH:mm:ss"
        let strNowTime = timeFormatter.stringFromDate(date) as String
//        print("time is \(strNowTime)")
//        let strNowTime = "2016-06-08.02:18:20"
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

