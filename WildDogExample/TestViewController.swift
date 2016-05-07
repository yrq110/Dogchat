//
//  TestViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/2.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import Wilddog
class TestViewController: UIViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    let WilddogURL = "https://yrq.wilddogio.com"
    var whiteActivityIndicator : UIActivityIndicatorView!
    var thumbnailImageView : UIImageView!
    var imageStr : String!
    var thumbnailImageStr : String!
    var isOrigin = false
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
