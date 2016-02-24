//
//  ViewController.h
//  商品详情页
//
//  Created by 本农记 on 16/2/16.
//  Copyright © 2016年 韩秀辉. All rights reserved.
//

#import <UIKit/UIKit.h>

// 当前设备屏幕尺寸
#define kSCREEN_RECT        ([UIScreen mainScreen].bounds)
// 当前设备屏幕宽度
#define kSCREEN_WIDTH       ([UIScreen mainScreen].bounds.size.width)
// 当前设备屏幕高度
#define kSCREEN_HEIGHT      ([UIScreen mainScreen].bounds.size.height)

// 状态栏高度
#define kSTATUSBAR_HEIGHT            (20.f)
// 导航栏高度
#define kNAVIGATION_HEIGHT           (44.f)
// 导航栏高度 + 状态栏高度
#define kSTATUSBAR_NAVIGATION_HEIGHT (64.f)
// 标签栏高度
#define kTABBAR_HEIGHT               (49.f)
// 英文键盘
#define KEYBOARD_HEIGHT_ENGLISH      (216.0f)
// 中文键盘
#define kKEYBOARD_HEIGHT_CHINESE     (252.0f)

// 底部工具条高度
#define kTOOLHEIGHT 50.f

@interface ViewController : UIViewController


@end

