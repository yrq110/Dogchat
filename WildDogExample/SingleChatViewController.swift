//
//  SingleChatViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class SingleChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    var tableView:UITableView?
    var cellHeight = Dictionary<Int,CGFloat>()
    var bottomView:InputView!
    var testText = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        mainViewInit()
        
        testText = ["你好","你好","今晚有空吗，商量个事","好的，我8点有空，来601吧","好的"]
    }
    
    func getName(name:String){
        
        self.title = name
    
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testText.count
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
        
        if indexPath.row % 2 == 0 {
            cell.myCell()
        } else {
            cell.otherCell()
        }
        
        cell.msgLabel!.text = self.testText[indexPath.row]
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
