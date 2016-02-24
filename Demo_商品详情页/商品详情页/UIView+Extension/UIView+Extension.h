//
//  UIView (Extension).h
//  HZProject
//
//  Created by KG on 15/8/17.
//  Copyright (c) 2015年 KG. All rights reserved.
//
//  因为控件的frame不能直接修改，必须整体赋值。所以重写方法，可以直接修改size，height，width，x，y

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  x坐标
 */
@property (assign, nonatomic) CGFloat x;

/**
 *  y坐标
 */
@property (assign, nonatomic) CGFloat y;

/**
 *  width
 */
@property (assign, nonatomic) CGFloat width;

/**
 *  height
 */
@property (assign, nonatomic) CGFloat height;

/**
 *  size
 */
@property (assign, nonatomic) CGSize size;

/**
 *  origin
 */
@property (assign, nonatomic) CGPoint origin;

/**
 *  中心x坐标
 */
@property (assign, nonatomic) CGFloat centerX;

/**
 *  中心y坐标
 */
@property (assign, nonatomic) CGFloat centerY;


/*--------------------上。左。下。右。------------------------*/
/**
 *  上
 */
@property (assign, nonatomic) CGFloat top;

/**
 *  左
 */
@property (assign, nonatomic) CGFloat left;

/**
 *  下
 */
@property (assign, nonatomic) CGFloat bottom;

/**
 *  右
 */
@property (assign, nonatomic) CGFloat right;


/*--------------------点------------------------*/
/**
 *  左下角
 */
@property (readonly) CGPoint bottomLeft;

/**
 *  右下角
 */
@property (readonly) CGPoint bottomRight;

/**
 *  右上角
 */
@property (readonly) CGPoint topRight;

/**
 *  左上角
 */
@property (readonly) CGPoint topLeft;


/**
 *  绘制cell分割线
 *
 *  @param rect      cell_rect
 *  @param lineWidth 线宽
 *  @param lineColor 线色
 */
- (void)drawCellSeparatorLine:(CGRect)rect lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

@end
