//
//  Base.m
//  test
//
//  Created by adoma on 16/6/14.
//  Copyright © 2016年 adoma. All rights reserved.
//

#import "Base.h"

@implementation Base

//iOS7之后该方法会调用两次，开始和返回。iOS7之前调用三次，最后一次时间戳不同。
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (![self pointInside:point withEvent:event]) {
        NSLog(@"触摸点不在Base");
        return nil;
    }
    
    NSLog(@"触摸点在Base");
    
    //最上面的需要额外判断
    UIView *top = self.subviews.lastObject;
    
    //触摸点坐标转换，从当前view转换到目标view
    CGPoint viewPoint = [self convertPoint:point toView:top];
    
    id responder = [top hitTest:viewPoint withEvent:event];
    
    if (responder) return responder;
        
    NSLog(@"触摸点在椭圆外");
    
    //遍历椭圆下面的view
    for (UIView *view in self.subviews) {
        
        NSLog(@"判读是不是%@",NSStringFromClass(view.class));
        
        //触摸点坐标转换，从当前view转换到目标view
        viewPoint = [self convertPoint:point toView:view];
        
        //判断转换后的点是不是在目标view上
        if ([view pointInside:viewPoint withEvent:event]) {
            
            return [view hitTest:viewPoint withEvent:event];
        }
    }
    
    return self;
}

@end
