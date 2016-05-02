//
//  SingleChatMessageCell.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/13.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class SingleChatMessageCell: UITableViewCell {
    
    var nickLabel:UILabel?
    var timeLabel:UILabel?
    var msgLabel:UILabel?
    var msgBackView:UIView?
    var avatar:UIImageView?
    var msgImageView:UIImageView?
    var msgTap:UITapGestureRecognizer!
    var msgPress:UILongPressGestureRecognizer!
    let move = MoveClass()
    var isMyCell = true
    let shallowGreen = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.3)
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    func myCell(){
        isMyCell = true
        avatar = UIImageView(frame: CGRectMake(SCREEN_WIDTH-45, 5, 40, 40))
        avatar!.image = UIImage(named: "moon")
        contentView.addSubview(avatar!)
        
        msgBackView = UILabel(frame:CGRectMake(move.moveLeftX(avatar!, offset: msgWidth+30.0),avatar!.yrq_y,msgWidth+20,30))
        msgBackView!.backgroundColor = UIColor.whiteColor()
        msgBackView!.layer.masksToBounds = true
        msgBackView!.layer.cornerRadius = 5.0
        contentView.addSubview(msgBackView!)
        
        msgLabel = UILabel(frame:CGRectMake(move.moveLeftX(avatar!, offset: msgWidth+20.0),avatar!.yrq_y+10,msgWidth,30))
        msgLabel!.backgroundColor = UIColor.clearColor()
        msgLabel!.font = UIFont.boldSystemFontOfSize(18.0)
        msgLabel!.numberOfLines = 0
        contentView.addSubview(msgLabel!)
        
        addGesture()
    }
    
    func otherCell(){
        isMyCell = false
        avatar = UIImageView(frame: CGRectMake(5, 5, 40, 40))
        avatar!.image = UIImage(named: "sun")
        contentView.addSubview(avatar!)
        
        msgBackView = UILabel(frame:CGRectMake(move.moveRightX(avatar!, offset: 10.0),avatar!.yrq_y,msgWidth+20,30))
        msgBackView!.backgroundColor = shallowGreen
        msgBackView!.layer.masksToBounds = true
        msgBackView!.layer.cornerRadius = 5.0
        contentView.addSubview(msgBackView!)
        
        msgLabel = UILabel(frame:CGRectMake(move.moveRightX(avatar!, offset: 20.0),avatar!.yrq_y+10,msgWidth,30))
        msgLabel!.backgroundColor = UIColor.clearColor()
        msgLabel!.font = UIFont.boldSystemFontOfSize(18.0)
        msgLabel!.numberOfLines = 0
        contentView.addSubview(msgLabel!)
        
        addGesture()
    }
    func addGesture(){
        msgPress = UILongPressGestureRecognizer()
        msgPress.addTarget(self, action: "gesture:")
        self.msgLabel!.addGestureRecognizer(msgPress)
        self.msgLabel!.userInteractionEnabled = true
    }
    
    func gesture(press:UILongPressGestureRecognizer){
        if press.state == UIGestureRecognizerState.Ended{
            self.msgBackView!.backgroundColor = isMyCell ? UIColor.whiteColor() : shallowGreen
            return
        }else if press.state == UIGestureRecognizerState.Began{
            print("I pressed")
            self.msgBackView!.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        }
    
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
