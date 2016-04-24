//
//  FirstTangramView.m
//  Tangram
//
//  Created by 袁灿 on 16/3/7.
//  Copyright © 2016年 yuancan. All rights reserved.
//

#import "FirstTangramView.h"

@implementation FirstTangramView

- (void)drawRect:(CGRect)rect
{
    UIColor *color = COLOR(17, 199, 216, 1);
    self.backgroundColor = color;
    [color set]; //设置线条颜色
    
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointMake(0, 0)];
    [self.path addLineToPoint:CGPointMake(1.0/2.0*SCREEN_WIDTH, 0)];
    [self.path addLineToPoint:CGPointMake(0, 3.0/7.0*SCREEN_HEIGHT)];
    [self.path closePath];
    [self.path fill];
    
    [self setMaskWithUIBezierPath:self.path];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    title.center = CGPointMake(40, 3.0/7.0*SCREEN_HEIGHT/2-40);
    title.text = @"Graffiti";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         title.transform = CGAffineTransformRotate(CGAffineTransformScale(title.transform, 1.5, 1.5), 0.2*M_PI); //缩放+旋转
                     }];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com