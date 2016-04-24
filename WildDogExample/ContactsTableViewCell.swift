//
//  ContactsTableViewCell.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/19.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    var avatarImageView : UIImageView?
    var nameLabel : UILabel?
    var mailLabel : UILabel?
    let move = MoveClass()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        avatarImageView = UIImageView(frame: CGRectMake(10, 10, 40, 40))
        avatarImageView!.image = UIImage(named: "sun")
        addSubview(avatarImageView!)
        
        nameLabel = UILabel(frame: CGRectMake(move.moveRightX(avatarImageView!, offset: 30),avatarImageView!.yrq_y,100,40))
        addSubview(nameLabel!)
        
        mailLabel = UILabel(frame: CGRectMake(move.moveRightX(nameLabel!, offset: 50),avatarImageView!.yrq_y,150,40))
        addSubview(mailLabel!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
