//
//  TangramBaseView.h
//  Tangram
//
//  Created by 袁灿 on 16/3/7.
//  Copyright © 2016年 yuancan. All rights reserved.
//

#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define kQtRate                     SCREEN_HEIGHT/SCREEN_WIDTH

#define COLOR(r,g,b,a) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)])

typedef void (^myBlock)(id result);

#import <UIKit/UIKit.h>

@interface TangramBaseView : UIView

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, copy) myBlock isClicked;

- (void)setMaskWithUIBezierPath:(UIBezierPath *)bezierPath;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com