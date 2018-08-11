//
//  UIColor+ChXRandom.m
//  ChXUIViewAnimationDemo
//
//  Created by Xu Chen on 2018/8/10.
//  Copyright © 2018年 xu.yzl. All rights reserved.
//

#import "UIColor+ChXRandom.h"

@implementation UIColor (ChXRandom)
+ (UIColor *)chx_randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

@end
