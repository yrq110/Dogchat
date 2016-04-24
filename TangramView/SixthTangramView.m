//
//  SixthTangramView.m
//  Tangram
//
//  Created by 袁灿 on 16/3/7.
//  Copyright © 2016年 yuancan. All rights reserved.
//

#import "SixthTangramView.h"

@implementation SixthTangramView

- (void)drawRect:(CGRect)rect
{
    UIColor *color = COLOR(117, 199, 216, 1);
    self.backgroundColor = color;
    [color set]; //设置线条颜色
    
    float x1 = 1.0/2.0*SCREEN_WIDTH+20;
    float y1 = -3.0/14.0*kQtRate*x1+6.0/7.0*SCREEN_HEIGHT;
    
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointMake(x1, y1)];
    [self.path addLineToPoint:CGPointMake(SCREEN_WIDTH, 9.0/14.0*SCREEN_HEIGHT)];
    [self.path addLineToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.path closePath];
    [self.path fill];

    [self setMaskWithUIBezierPath:self.path];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    title.center = CGPointMake(x1+(SCREEN_WIDTH-x1)/2+20, y1 +20);
    title.text = @"Scrum";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:10.0f];
    title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         title.transform = CGAffineTransformRotate(CGAffineTransformScale(title.transform, 1.5, 1.5), -0.2*M_PI); //缩放+旋转
                     }];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com