//
//  yrq_alert.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/4.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

extension UIView{
    
    var yrq_height:CGFloat{
        set(v){
            self.frame.size.height = v
        }
        get{
            return self.frame.size.height
        }
    }
    
    var yrq_width:CGFloat{
        set(v){
            self.frame.size.width = v
        }
        get{
            return self.frame.size.width
        }
    }
    
    var yrq_x:CGFloat{
        set(v){
            self.frame.origin.x = v
        }
        get{
            return self.frame.origin.x
        }
    }
    
    var yrq_y:CGFloat{
        set(v){
            self.frame.origin.y = v
        }
        get{
            return self.frame.origin.y
        }
    }
}