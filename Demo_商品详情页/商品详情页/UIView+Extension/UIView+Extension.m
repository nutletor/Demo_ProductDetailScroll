//
//  UIView (Extension).m
//  HZProject
//
//  Created by KG on 15/8/17.
//  Copyright (c) 2015年 KG. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}


/*--------------------华丽分割线------------------------*/

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.origin.y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.origin.x;
    self.frame = frame;
}


/*--------------------华丽分割线------------------------*/
- (CGPoint)bottomLeft {
    CGFloat bottomX = self.frame.origin.x;
    CGFloat bottomY = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(bottomX, bottomY);
}

- (CGPoint)bottomRight {
    CGFloat bottomX = self.frame.origin.x + self.frame.size.width;
    CGFloat bottomY = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(bottomX, bottomY);
}

- (CGPoint)topLeft {
    CGFloat topX = self.frame.origin.x;
    CGFloat topY = self.frame.origin.y;
    return CGPointMake(topX, topY);
}

- (CGPoint)topRight {
    CGFloat topX = self.frame.origin.x + self.frame.size.width;
    CGFloat topY = self.frame.origin.y;
    return CGPointMake(topX, topY);
}

- (void)drawCellSeparatorLine:(CGRect)rect lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    // 开启上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 上分割线，
    CGContextSetStrokeColorWithColor(context,lineColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, -0.5, rect.size.width, lineWidth));
    
    // 下分割线
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, lineWidth));
}
@end
