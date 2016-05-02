//
//  ArticleViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/31.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, LazyFadeInViewDelegate {

    var backgroundColor:UIColor!
    var lazyFadeInView: LazyFadeInView?
//    let strayBirds = " Stray birds of summer come to my window to sing and fly away. And yellow leaves of autumn, which have no songs, flutter and fall there with a sign. O Troupe of little vagrants of the world, leave your footprints in my words."
    
    let strayBirds = " 大年你要对我有信心"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.backgroundColor
        self.lazyFadeInView = LazyFadeInView.init(frame: CGRectMake(20, 100, UIScreen.mainScreen().bounds.size.width - 40, 200))
        self.lazyFadeInView?.textColor = UIColor.blackColor()
        self.lazyFadeInView?.text = strayBirds
        self.lazyFadeInView?.delegate = self
        self.lazyFadeInView?.textColor = UIColor.whiteColor()
        self.view.addSubview(lazyFadeInView!)
    }

    func fadeInAnimationDidEnd(fadeInView: LazyFadeInView) {
        print("fade in animation did end")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
