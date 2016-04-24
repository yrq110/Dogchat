//
//  TangramBaseView.m
//  Tangram
//
//  Created by 袁灿 on 16/3/7.
//  Copyright © 2016年 yuancan. All rights reserved.
//

#import "TangramBaseView.h"

@implementation TangramBaseView

- (void)setMaskWithUIBezierPath:(UIBezierPath *)bezierPath
{
    //蒙板
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [bezierPath CGPath];
    maskLayer.fillColor = [[UIColor redColor] CGColor];
    maskLayer.frame = self.bounds;
    self.layer.mask = maskLayer;
    
    //边框蒙板
    CAShapeLayer *maskBorderLayer = [CAShapeLayer layer];
    maskBorderLayer.path = [bezierPath CGPath];
    maskBorderLayer.fillColor = [[UIColor clearColor] CGColor];
    maskBorderLayer.strokeColor = self.backgroundColor.CGColor;//边框颜色
    maskBorderLayer.lineWidth = 1; //边框宽度
    [self.layer addSublayer:maskBorderLayer];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result = [self.path containsPoint:point];
    return result;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.isClicked) {
        self.isClicked(self);
    }
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com