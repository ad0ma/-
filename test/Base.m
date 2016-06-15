//
//  Base.m
//  test
//
//  Created by adoma on 16/6/14.
//  Copyright © 2016年 adoma. All rights reserved.
//

#import "Base.h"

@implementation Base

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
    
    //判断转换后的点是不是在目标view上
    if ([top pointInside:viewPoint withEvent:event]) {
        
        NSLog(@"%@",NSStringFromClass(top.class));
        
        return top;
        
        
    } else {
        
        for (UIView *view in self.subviews) {
            
            //触摸点坐标转换，从当前view转换到目标view
            viewPoint = [self convertPoint:point toView:view];
            
            //判断转换后的点是不是在目标view上
            if ([view pointInside:viewPoint withEvent:event]) {
                
                
                return [view hitTest:viewPoint withEvent:event];
            }
        }

    }
    
    return self;
}

@end
