//
//  PersonDetailView.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/19.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class PersonDetailView: UIView {
    
    var avatar:UIImageView!
    var nickname:UILabel!
    var name:UILabel!
    var position:UILabel!
    var department:UILabel!
    var chat:UILabel!
    var viewArray = Array<UIView>()
    var move = MoveClass()
    var chatTap:UITapGestureRecognizer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        avatar = UIImageView(frame: CGRectMake(150, 100, 60, 60))
//        avatar.image = UIImage(named: "sun")
        avatar.center.x = SCREEN_WIDTH/2
        addSubview(avatar)
        viewArray.append(avatar)
        
        nickname = UILabel(frame: CGRectMake(50, move.moveBottomY(avatar, offset: 20), 200, 60))
        nickname.center.x = SCREEN_WIDTH/2
        viewArray.append(nickname)

        name = UILabel(frame: CGRectMake(50, move.moveBottomY(nickname, offset: 20), 200, 60))
        name.center.x = SCREEN_WIDTH/2
        viewArray.append(name)

        position = UILabel(frame: CGRectMake(50, move.moveBottomY(name, offset: 20), 200, 60))
        position.center.x = SCREEN_WIDTH/2
        viewArray.append(position)

        department = UILabel(frame: CGRectMake(50, move.moveBottomY(position, offset: 20), 200, 60))
        department.center.x = SCREEN_WIDTH/2
        viewArray.append(department)
        
        chat = UILabel(frame: CGRectMake(50, move.moveBottomY(department, offset: 20), 200, 60))
        chat.center.x = SCREEN_WIDTH/2
        chat.text = "发信息"
        viewArray.append(chat)
        
        chatTap = UITapGestureRecognizer()
        chatTap.numberOfTapsRequired = 1
        chatTap.addTarget(self, action: "beginChat")
        chat.addGestureRecognizer(chatTap)
        chat.userInteractionEnabled = true
        
        labelInit()
        
    }
    
    func labelInit(){
        for i in 0...viewArray.count-1 {
            if viewArray[i].isKindOfClass(UILabel){
                let textLabel = viewArray[i] as! UILabel
                textLabel.textAlignment = NSTextAlignment.Center
                textLabel.layer.masksToBounds = true
                textLabel.layer.cornerRadius = 20.0
                textLabel.layer.borderWidth = 5.0
                textLabel.layer.borderColor = UIColor.redColor().CGColor
                self.addSubview(textLabel)
                
                var transform = CATransform3DMakeTranslation(0, textLabel.frame.size.height/2, 0)
                transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 1, 0, 0)
                //        transform2.m34 = -5.0/500.0
                textLabel.layer.transform = transform
                UIView.animateWithDuration(2, delay: 0.5*Double(i), options: UIViewAnimationOptions.TransitionNone, animations: {
                    textLabel.transform = CGAffineTransformIdentity
                    }, completion: {_ in
                })
            }
//            UIView.animateWithDuration(2, animations: {
//                textLabel.transform = CGAffineTransformIdentity
//                }, completion: { _ in
//                    UIView.animateWithDuration(2, animations: {
//                        //                    textLabel.removeFromSuperview()
//                    })
//                    
//            })
        }
    }

    func setMessage(image_:UIImage,nickname_:String,name_:String,position_:String,department_:String){
        avatar.image = image_
        nickname.text = nickname_
        name.text = name_
        position.text = position_
        department.text = department_
    }
    
    func beginChat(){
        removeFromSuperview()
//        let singleView = SingleChatViewController()
//        singleView.getName(self.nickname.text)
//        self.navigationController!.pushViewController(singleView, animated: true)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

}
