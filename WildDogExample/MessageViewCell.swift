//
//  MessageViewCell.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/28.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    var timeLabel:UILabel?
    var nickLabel:UILabel?
    var msgLabel:UILabel?
    var bottomLine:UIView?
    override func awakeFromNib() {
//        super.awakeFromNib()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.nickLabel = UILabel(frame:CGRectMake(5,0,SCREEN_WIDTH/2,20))
        self.nickLabel!.font = UIFont.systemFontOfSize(12.0)
        self.addSubview(self.nickLabel!)
        
        self.msgLabel = UILabel(frame:CGRectMake(5,20,SCREEN_WIDTH/2,20))
        self.msgLabel!.font = UIFont.boldSystemFontOfSize(18.0)
        self.msgLabel!.numberOfLines = 0

        self.addSubview(self.msgLabel!)
        
        self.timeLabel = UILabel(frame:CGRectMake(5,40,SCREEN_WIDTH/2,20))
        self.timeLabel!.font = UIFont.systemFontOfSize(14.0)
        self.addSubview(self.timeLabel!)
        
        self.bottomLine = UIView(frame: CGRectMake(5,60,SCREEN_WIDTH/2,5))
        self.bottomLine!.backgroundColor = UIColor.redColor()
        self.addSubview(self.bottomLine!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
