//
//  KCAnnotation.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/5/7.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import MapKit
class RQAnnotation: NSObject,MKAnnotation{
    
    var coordinate:CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    var image:UIImage?
    init(coordinate:CLLocationCoordinate2D,title:String?,subtitle:String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
