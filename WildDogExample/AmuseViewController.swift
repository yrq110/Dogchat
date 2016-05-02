//
//  AmuseViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/8.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class AmuseViewController: UIViewController,UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var imageView:UIImageView!
    var imageView2:UIImageView!
    var currentImage:UIImage!
    
    private let labelFont = UIFont(name: "Menlo", size: 7)!
//    private let labelFont = UIFont(name: "Menlo", size: 2)!
    private let maxImageSize = CGSizeMake(310, 310)
    private lazy var palette: AsciiPalette = AsciiPalette(font: self.labelFont)
    
    private var currentLabel: UILabel?
    private var busyView: UIView!
    private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentImage = UIImage()
        
        btnAndImageInit()
        configureZoomSupport()
        displayImageNamed("moon")
    }
    
    func btnAndImageInit() {
    
        scrollView = UIScrollView(frame: CGRectMake(0,64,SCREEN_WIDTH,400))
        scrollView.userInteractionEnabled = true
        view.addSubview(scrollView)
        
        busyView = UIView(frame: CGRectMake(0,64,SCREEN_WIDTH,400))
        busyView.backgroundColor = UIColor.greenColor()
        view.addSubview(busyView)
        
        let btn = UIButton(type: .System)
        btn.frame = CGRectMake(0,SCREEN_HEIGHT-50,80,40)
        btn.setTitle("Photo", forState: UIControlState.Normal)
        btn.addTarget(self, action: "handlePickImageTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn)
        
        let btn2 = UIButton(type: .System)
        btn2.frame = CGRectMake(SCREEN_WIDTH-80,SCREEN_HEIGHT-50,80,40)
        btn2.setTitle("Trans", forState: UIControlState.Normal)
        btn2.addTarget(self, action: "btnTrans", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn2)
    }
    
    func btnTrans() {
    
    
    }
    
    func imageViewInit() {
        
        SDImageCache.sharedImageCache().clearDisk()
        imageView = UIImageView()
        var frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*3.0/4.0)
        imageView.frame = frame
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: "tapGesture")
        imageView.addGestureRecognizer(tap)
        imageView.userInteractionEnabled = true
        self.view.addSubview(imageView)
        
        imageView2 = UIImageView()
        var frame2 = CGRectMake(0, 74+self.view.frame.size.width*3.0/4.0, self.view.frame.size.width, self.view.frame.size.width*3.0/4.0)
        imageView2.frame = frame2
        
        let tap2 = UITapGestureRecognizer()
        tap2.numberOfTapsRequired = 2
        tap2.addTarget(self, action: "tapGesture")
        imageView2.addGestureRecognizer(tap2)
        imageView2.userInteractionEnabled = true
        self.view.addSubview(imageView2)
        imageView.sd_setImageWithURL(NSURL(string: "https://source.unsplash.com/category/nature/800x600"), completed: { (image:UIImage!, error:NSError!, cacheType:SDImageCacheType, url:NSURL!) -> Void in
            SDImageCache.sharedImageCache().clearDisk()
            print(SDImageCache.sharedImageCache().getSize())
        })
    
    }
    
    var i = 0
    func tapGesture() {
        switch i {
        case 0: UIView.animateWithDuration(0.5, animations: {
                    let a:CGFloat = CGFloat(90*(M_PI/180.0))
                    self.imageView.transform = CGAffineTransformMakeRotation(a)
                    }, completion: {
                        (finished:Bool) -> Void in
                        UIView.animateWithDuration(0.5, animations: {
                            self.imageView.frame = self.view.frame
                        })
                    }
                )
                i = 1
        case 1: UIView.animateWithDuration(0.5, animations: {
                    self.imageView.layer.setAffineTransform(CGAffineTransformIdentity)
                    }, completion: {
                        (finished:Bool) -> Void in
                        UIView.animateWithDuration(0.5, animations: {
                            self.imageView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*3.0/4.0)
                        })
                    }
                )
                i = 0
        default: print("cool")
        }
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
            displayImage(image)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Rendering
    
    private func displayImageNamed(imageName: String)
    {
        displayImage(UIImage(named: imageName)!)
    }
    
    private func displayImage(image: UIImage)
    {
        self.busyView.hidden = false
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            
            let // Rotate first because the orientation is lost when resizing.
            rotatedImage = image.imageRotatedToPortraitOrientation(),
            resizedImage = rotatedImage.imageConstrainedToMaxSize(self.maxImageSize),
            asciiArtist  = AsciiArtist(resizedImage, self.palette),
            asciiArt     = asciiArtist.createAsciiArt()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.displayAsciiArt(asciiArt)
                self.busyView.hidden = true
            }
            
            print(asciiArt)
        }
        
    }
    
    private func displayAsciiArt(asciiArt: String)
    {
        let label = UILabel()
        label.font = self.labelFont
        label.lineBreakMode = NSLineBreakMode.ByClipping
        label.numberOfLines = 0
        label.text = asciiArt
        label.sizeToFit()
        
        currentLabel?.removeFromSuperview()
        currentLabel = label
        
        scrollView.addSubview(label)
        scrollView.contentSize = label.frame.size
//        scrollView.minimumZoomScale = 0.5
//        scrollView.setZoomScale(0.5, animated: true)
        self.updateZoomSettings(animated: false)
        scrollView.contentOffset = CGPointZero
    }
    
    // MARK: - Zooming support
    
    private func configureZoomSupport()
    {
        scrollView.delegate = self
        scrollView.maximumZoomScale = 5
    }
    
    private func updateZoomSettings(animated animated: Bool)
    {
        let
        scrollSize  = scrollView.frame.size,
        contentSize = scrollView.contentSize,
        scaleWidth  = scrollSize.width / contentSize.width,
        scaleHeight = scrollSize.height / contentSize.height,
        scale       = max(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = scale
        scrollView.setZoomScale(scale, animated: animated)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return currentLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
