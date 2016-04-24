//
//  ConstantValue.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/13.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import Foundation

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
let msgWidth:CGFloat = 180.0

class MoveClass {

    func moveRightX(view:UIView,offset:CGFloat) -> CGFloat{
        
        return view.yrq_width+view.yrq_x+offset
    }

    func moveLeftX(view:UIView,offset:CGFloat) ->CGFloat{
    
        return view.yrq_x-offset
    }
    
    func moveBottomY(view:UIView,offset:CGFloat) -> CGFloat{
        
        return view.yrq_y+view.yrq_height+offset
    }
}