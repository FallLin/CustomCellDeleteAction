//
//  LQMainViewController.h
//  CustomCellDeleteAction
//
//  Created by monkey on 2017/11/29.
//  Copyright © 2017年 luqiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WeakObj(obj) __weak typeof(obj) obj##Weak = obj
#define StrongObj(obj) __strong typeof(obj) obj ## Strong = obj##Weak

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@interface LQMainViewController : UIViewController

@end
