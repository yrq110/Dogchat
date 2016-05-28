//
//  TestViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/2.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import Wilddog
import MapKit
class TestViewController: UIViewController,
                        UIImagePickerControllerDelegate,
                        UINavigationControllerDelegate,
                        MKMapViewDelegate,
                        CLLocationManagerDelegate{
    let WilddogURL = "https://yrq.wilddogio.com"
    var whiteActivityIndicator : UIActivityIndicatorView!
    var thumbnailImageView : UIImageView!
    var imageStr : String!
    var thumbnailImageStr : String!
    var isOrigin = false
    var locationManager = CLLocationManager()
    var mapView = MKMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //encoding
//        var image = UIImage(named: "moon.png")
//        var data = UIImageJPEGRepresentation(image!, 1.0)!
//        var imageStr:String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
//        print("str is \(imageStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))")
        
        //decoding
//        var imageData = NSData(base64EncodedString: imageStr, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
//        var image2 = UIImage(data: imageData!)
//        let imageView = UIImageView(frame: CGRectMake(10,10,100,100))
//        imageView.image = image2
//        view.addSubview(imageView)

        //upload pic_codec
//        let myRootRef = Wilddog(url:self.WilddogURL)
//        let msgRef = myRootRef.childByAppendingPath("UserPicture")
//        let Ref = msgRef.childByAutoId()
//        Ref.setValue(imageStr)
//        print(imageStr)
        
//        childChange()
        
//        getPicFromAlbum()
        
        mapkit()
    }
    
    func mapkit(){
        
        if !CLLocationManager.locationServicesEnabled() {
            print("定位服务当前可能尚未打开，请设置打开！")
        }
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined){
            locationManager.requestWhenInUseAuthorization()
            print("no")
        }else if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            let distance:CLLocationDistance = 2.0
            locationManager.distanceFilter = distance
            locationManager.startUpdatingLocation()
            print("yes")
        }
        
        mapView.frame = self.view.frame
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.Follow
        mapView.mapType = MKMapType.Standard
        
        
        addAnnotation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation? = locations.first
        let coordinate:CLLocationCoordinate2D = location!.coordinate
        print("经度：\(coordinate.longitude),纬度：\(coordinate.latitude),海拔：\(location!.altitude),航向：\(location!.course),行走速度：\(location!.speed)")
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let center:CLLocation = CLLocation(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
            span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
//        self.locationManager.stopUpdatingLocation()
    }
    
    func addAnnotation(){
//        let location1 = CLLocationCoordinate2DMake(39.95, 116.35)
//        let annotaion1 = RQAnnotation(coordinate: location1,title: "123",subtitle: "456")
//        self.mapView.addAnnotation(annotaion1)
        
        let objectAnnotation = MKPointAnnotation()
        //设置大头针的显示位置
        objectAnnotation.coordinate = CLLocation(latitude: 39.95,
            longitude: 116.35).coordinate
        //设置点击大头针之后显示的标题
        objectAnnotation.title = "南京夫子庙"
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = "南京市秦淮区秦淮河北岸中华路"
        //添加大头针
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
//        else{
//            return nil
//        }
        
        let reuserId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuserId)
            as? MKPinAnnotationView
        if pinView == nil {
            //创建一个大头针视图
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuserId)
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            //设置大头针颜色
//            pinView?.pinTintColor = UIColor.greenColor()
            //设置大头针点击注释视图的右侧按钮样式
            pinView?.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "sun.png"))
            pinView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }else{
            pinView?.annotation = annotation
        }
        return pinView
//        if annotation.isKindOfClass(RQAnnotation) {
//            let key = "AnnotationKey"
//            let annotationView = self.mapView.dequeueReusableAnnotationViewWithIdentifier(key)
//            if annotationView == nil {
//                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: key)
//                annotationView.canShowCallout = true
//                annotationView.calloutOffset = CGPointMake(0,1)
//                annotationView.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "sun.png"))
//                annotationView.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure)
//                print("hahaha")
//            }else{
//                annotationView?.annotation = annotation
//                annotationView?.image = (annotation as! RQAnnotation).image
//            }
//            return annotationView
//        }else{
//            return nil
//        }
    }
    
    func getPicFromAlbum(){
        let btn = UIButton(type: UIButtonType.System)
        btn.frame = CGRectMake(10,100,100,30)
        btn.setTitle("Photo", forState: UIControlState.Normal)
        btn.addTarget(self, action: "handlePickImageTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn)
    }
    
    // MARK: - Actions
    
    func handlePickImageTapped(sender: AnyObject)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.showViewController(imagePicker, sender: self)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            print("select photo")
            let newImage = imageCompressForWidth(image, targetWidth: SCREEN_WIDTH)
//            print(newImage.size)
            let data = UIImageJPEGRepresentation(newImage, 1.0)!
            imageStr = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
//            print(imageStr)
            
            
            let newImageThumbnail = imageCompressForWidth(image, targetWidth: 100)
            let data2 = UIImageJPEGRepresentation(newImageThumbnail, 1.0)!
            thumbnailImageStr = data2.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            thumbnailImageView = UIImageView(frame: CGRectMake(100,200,newImageThumbnail.size.width,newImageThumbnail.size.height))
            thumbnailImageView.image = newImageThumbnail
            let tap = UITapGestureRecognizer()
            tap.addTarget(self, action: "restorePic")
            thumbnailImageView.addGestureRecognizer(tap)
            thumbnailImageView.userInteractionEnabled = true
            self.view.addSubview(thumbnailImageView)
        }
    }
    
    func restorePic(){
        if !isOrigin {
            decodingPicture(imageStr, origin: CGPointMake(0, 300), imageView: thumbnailImageView)
            isOrigin = true
        } else {
            decodingPicture(thumbnailImageStr, origin: CGPointMake(100, 200), imageView: thumbnailImageView)
            isOrigin = false
        }
    }
    
    func decodingPicture(imageStr:String,origin:CGPoint,imageView:UIImageView){
        let imageData = NSData(base64EncodedString: imageStr, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let image = UIImage(data: imageData!)
        UIView.animateWithDuration(1.0, animations: {
            imageView.image = image
            imageView.frame.origin = CGPointMake(origin.x, origin.y)
            imageView.frame.size = CGSizeMake(image!.size.width, image!.size.height)
        })

    
    }
    func imageCompressForWidth(sourceImage:UIImage ,targetWidth:CGFloat) -> UIImage {
        let imageSize = sourceImage.size
        let width = imageSize.width
        let height = imageSize.height
        let targetHeight = (targetWidth / width) * height
        UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight))
        sourceImage.drawInRect(CGRectMake(0, 0, targetWidth, targetHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var i:CGFloat = 0
    func childChange() {
        //get pic_codec
        let myRootRef = Wilddog(url:self.WilddogURL)
        let msgRef = myRootRef.childByAppendingPath("UserPicture")
        msgRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if snapshot.value != nil {
//                print(snapshot.value)
                self.i++
                let imageStr = snapshot.value as! String
                let imageData = NSData(base64EncodedString: imageStr, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                let image2 = UIImage(data: imageData!)
                let imageView = UIImageView(frame: CGRectMake(10,10+110*self.i,100,100))
                imageView.image = image2
                self.view.addSubview(imageView)
                print("i is \(self.i)")
            }
        })
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
