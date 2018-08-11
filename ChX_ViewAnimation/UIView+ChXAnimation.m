//
//  UIView+ChXAnimation.m
//  ChXUIViewAnimationDemo
//
//  Created by Xu Chen on 2018/8/10.
//  Copyright © 2018年 xu.yzl. All rights reserved.
//

#import "UIView+ChXAnimation.h"

float radiansForDegrees(int degrees) {
    return degrees * M_PI / 180;
}

@implementation UIView (ChXAnimation)

- (void)chx_animation_errorShake {
    [self chx_animation_errorShakeWithVigourOfShake:0.02];
}

- (void)chx_animation_errorShakeWithVigourOfShake:(float)vigour {
    // 晃动次数
    int numberOfShakes = 4;
    // 晃动幅度（相对于总宽度）
    float vigourOfShake = vigour;
    // 晃动延续时常（秒）
    float durationOfShake = 0.5f;
    
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGRect frame = self.frame;
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame));
    for (int index = 0; index < numberOfShakes; index++) {
        // 添加晃动路径 幅度由大变小
        CGPathAddLineToPoint(shakePath, NULL, CGRectGetMidX(frame) - frame.size.width * vigourOfShake*(1-(float)index/numberOfShakes),CGRectGetMidY(frame));
        CGPathAddLineToPoint(shakePath, NULL,  CGRectGetMidX(frame) + frame.size.width * vigourOfShake*(1-(float)index/numberOfShakes),CGRectGetMidY(frame));
    }
    
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = durationOfShake;
    CFRelease(shakePath);
    
    // 添加动画到输入框 layer上
    [self.layer addAnimation:shakeAnimation forKey:kCATransition];
}

- (void)chx_animation_addSubViewWithFadeAnimation:(UIView *)subView {
    // 子视图原透明度
    CGFloat orginAlpha = subView.alpha;
    
    subView.alpha = 0.0;
    [self addSubview:subView];
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         subView.alpha = orginAlpha;
                     }
                     completion:nil];
}

- (void)chx_animation_changeAlpha:(CGFloat)newAlpha duration:(double)duration {
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = newAlpha;
    } completion:nil];
}
- (void)chx_animation_changeAlpha:(CGFloat)newAlpha {
    [self chx_animation_changeAlpha:newAlpha duration:0.2];
}

- (void)chx_animation_rotationWithDuration:(CGFloat)duration
                                           isRepeat:(BOOL)isRepeat
                                        isClockwise:(BOOL)isClockwise {
    [UIView animateWithDuration:duration / 4
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         int degree = isClockwise ? 90 : 270;
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(degree));
    } completion:^(BOOL finished) {
        if (isRepeat) {
            [self chx_animation_rotationWithDuration:duration isRepeat:YES isClockwise:isClockwise];
        }
    }];
}

- (void)chx_animation_rotation:(BOOL)isRepeat isClockwise:(BOOL)isClockwise{
    [self chx_animation_rotationWithDuration:0.2 isRepeat:isRepeat isClockwise:isClockwise];
}

- (void)chx_animation_moveTo:(CGPoint)destination duration:(CGFloat)duration {
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
    }];
}
- (void)chx_animation_moveTo:(CGPoint)destination {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)chx_animation_alertPop {
    self.center = self.superview.center;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = 0.3;
    [self.layer addAnimation:animation forKey:@"bouce"];
}

- (void)chx_animation_alertDismiss {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
