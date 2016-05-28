//
//  MKMapViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/5/8.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import MapKit
import Wilddog
class MKMapViewController: UIViewController ,
                        UINavigationControllerDelegate,
                        MKMapViewDelegate,
                        CLLocationManagerDelegate{
    
    let myRootRef = Wilddog(url:WilddogURL)
    var msgPath:String!
    var userName1:String!
    var userName2:String!
    var userID:String!
    var userNickname:String!
    var locationManager = CLLocationManager()
    var mapView = MKMapView()
    var longitude:Double!
    var latitude:Double!
    var coordinateStr:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.frame = self.view.frame
        mapView.delegate = self
        mapView.mapType = MKMapType.Standard
        view.addSubview(mapView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func MyLocationInit(){
        
        if !CLLocationManager.locationServicesEnabled() {
            print("定位服务当前可能尚未打开，请设置打开！")
        }
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined){
            locationManager.requestWhenInUseAuthorization()
//            print("no")
        }else if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            let distance:CLLocationDistance = 2.0
            locationManager.distanceFilter = distance
            locationManager.startUpdatingLocation()
//            print("yes")
        }
        
        mapView.userTrackingMode = MKUserTrackingMode.Follow

    }
    
    func otherLocationInit(){
        
        print("OtherPositon is \(OtherPostion)")
        let objectAnnotation = MKPointAnnotation()
        let lati = (OtherPostion["latitude"]! as NSString).doubleValue
        let longi = (OtherPostion["longitude"]! as NSString).doubleValue
        objectAnnotation.coordinate = CLLocation(latitude: lati,
            longitude: longi).coordinate
        objectAnnotation.title = "\(OtherName)的位置"
        objectAnnotation.subtitle = "subtitle"
        self.mapView.addAnnotation(objectAnnotation)
        
        mapSetRegion(longi, latitude: lati, isMy: false)
    
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation? = locations.first
        let coordinate:CLLocationCoordinate2D = location!.coordinate
//        print("经度：\(coordinate.longitude),纬度：\(coordinate.latitude),海拔：\(location!.altitude),航向：\(location!.course),行走速度：\(location!.speed)")
        mapSetRegion(location!.coordinate.longitude, latitude: location!.coordinate.latitude, isMy: true)
        self.coordinateStr = "position:\(self.longitude),\(self.latitude)"
        print("MyPosition is \(self.coordinateStr)")
        savePostion()
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func mapSetRegion(longitude:Double,latitude:Double,isMy:Bool){
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let center:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
            span: currentLocationSpan)
        if isMy {
            (self.longitude,self.latitude) = (center.coordinate.longitude,center.coordinate.latitude)
        }
        mapView.setRegion(currentRegion, animated: true)
    
    }
    
    func savePostion(){
        let myRootRef = Wilddog(url:WilddogURL)
        let msgRef = myRootRef.childByAppendingPath(self.msgPath)
        let Ref = msgRef.childByAppendingPath("/position_\(self.userNickname)")
        let time = Time()
        let msg = ["ID":self.userID,"nickname":self.userNickname,"message":self.coordinateStr,"time":time.getTime()]
        Ref.setValue(msg)
//        print("beforeSet+\(msg)")
    }
    
    func transValue(userID:String!,userNickname:String!,msgPath:String!,isMyLocation:Bool,isOtherLocation:Bool) {
        self.userID = userID
        self.userNickname = userNickname
        self.msgPath = msgPath
        print("trans successed:\(self.msgPath),\(self.userNickname)")
        if isMyLocation {
            self.MyLocationInit()
        } else {
            self.otherLocationInit()
        }
    }
}
