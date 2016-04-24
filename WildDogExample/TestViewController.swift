//
//  TestViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/2.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class TestViewController: UIViewController{
    let WilddogURL = "https://wild-dragon-40947.wilddogio.com"

    var whiteActivityIndicator : UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = PersonDetailView(frame: self.view.frame)
        view.addSubview(person)
        
    }
    
    
    func resposity() {
//        let dateStr = self.chatMsgArray[indexPath.row]
//        //        cell.textLabel?.text = self.dic[dateStr]!["nickname"]!+":"+self.dic[dateStr]!["message"]!+"   time:"+dateStr
//        let message:String = self.dic[dateStr]!["message"]!
//        let nickName:String = self.dic[dateStr]!["nickname"]!
//        if nickName == self.userNickName {
//            let cellIdentifier = "MyMsgViewCell"
//            var cell:MyMsgViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MyMsgViewCell
//            if (cell == nil) {
//                cell = MyMsgViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
//            }
//            cell.msgLabel!.text = message
//            cell.timeLabel!.text = dateStr
//            cell.nickLabel!.text = nickName
//            cell.msgLabel!.sizeToFit()
//            var rect:CGRect = cell.msgLabel!.frame
//            rect.size.width = 160.0;
//            cell.msgLabel!.frame = rect
//            self.adjustY(cell.timeLabel!, upLabel: cell.msgLabel!)
//            self.adjustY(cell.bottomLine!, upLabel: cell.timeLabel!)
//            self.cellHeight[indexPath.row] = cell.bottomLine!.frame.origin.y+cell.bottomLine!.frame.size.height+2.0
//            cell.selectionStyle = UITableViewCellSelectionStyle.None
//            cell.backgroundColor = UIColor.clearColor()
//            
//            return cell
//        }else{
//            let cellIdentifier = "MessageViewCell"
//            var cell:MessageViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MessageViewCell
//            if (cell == nil) {
//                cell = MessageViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
//            }
//            cell.msgLabel!.text = message
//            cell.timeLabel!.text = dateStr
//            cell.nickLabel!.text = nickName
//            cell.msgLabel!.sizeToFit()
//            var rect2:CGRect = cell.msgLabel!.frame
//            rect2.size.width = 160.0;
//            cell.msgLabel!.frame = rect2
//            self.adjustY(cell.timeLabel!, upLabel: cell.msgLabel!)
//            self.adjustY(cell.bottomLine!, upLabel: cell.timeLabel!)
//            
//            self.cellHeight[indexPath.row] = cell.bottomLine!.frame.origin.y+cell.bottomLine!.frame.size.height+2.0
//            cell.selectionStyle = UITableViewCellSelectionStyle.None
//            cell.backgroundColor = UIColor.clearColor()
//            return cell
//        }
    
    
    }
    
    func activityInit() {
        
        whiteActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        whiteActivityIndicator.frame = CGRectMake(100, 100, 100, 100)
        whiteActivityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
        whiteActivityIndicator.color = UIColor.blackColor()
        whiteActivityIndicator.hidesWhenStopped = true
        whiteActivityIndicator.startAnimating()
        view.addSubview(whiteActivityIndicator)
        
        let btn = UIButton(type: UIButtonType.System)
        btn.frame = CGRectMake(100, 400, 80, 40)
        btn.setTitle("stop", forState: UIControlState.Normal)
        btn.addTarget(self, action: "click", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn)
    
    }
    func click(){
        
        whiteActivityIndicator.stopAnimating()
        let load = LoadingAnimeView(frame: view.frame)
        load.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
        view.addSubview(load)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
