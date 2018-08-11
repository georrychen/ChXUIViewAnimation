//
//  UIView+ChXAnimation.h
//  ChXUIViewAnimationDemo
//
//  Created by Xu Chen on 2018/8/10.
//  Copyright © 2018年 xu.yzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ChXAnimation)

/**
 左右抖动动画

 @param vigour 晃动幅度（相对于总宽度）, 默认 0.02
 */
- (void)chx_animation_errorShakeWithVigourOfShake:(float)vigour;
/**
 左右抖动动画：输入框信息错误时调用，如 用户名 为空
 */
- (void)chx_animation_errorShake;

/**
 修改视图透明度

 @param newAlpha 新透明度
 @param duration 动画时间
 */
- (void)chx_animation_changeAlpha:(CGFloat)newAlpha duration:(double)duration;
/**
 修改视图透明度
 */
- (void)chx_animation_changeAlpha:(CGFloat)newAlpha;

/**
 以渐变动画方式添加子视图
 
 @param subView 子视图
 */
- (void)chx_animation_addSubViewWithFadeAnimation:(UIView *)subView;

/**
 旋转

 @param duration 动画持续时间
 @param isRepeat 是否重复动画
 @param isClockwise 是否是顺时针
 */
- (void)chx_animation_rotationWithDuration:(CGFloat)duration
                                  isRepeat:(BOOL)isRepeat
                               isClockwise:(BOOL)isClockwise;

/**
 平移动画 (x,y)

 @param destination 目标point
 @param duration 动画持续时间
 */
- (void)chx_animation_moveTo:(CGPoint)destination duration:(CGFloat)duration;
/**
 平移动画 (x,y)
 */
- (void)chx_animation_moveTo:(CGPoint)destination;


// MARK: - 弹窗动画
/**
 动画弹出
 
 常常配合使用：
 pop {
      1. 修改 弹窗 和 遮罩层 的透明度
        self.alertView.alpha = 0;
        self.shadowBgView.alpha = 0;
     [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.alpha = 1;
        self.shadowBgView.alpha = 0.65;
 
     } completion:^(BOOL finished) {
     }];
 
     2. 动画弹出 弹窗
     [self.alertView chx_animation_alertPop];
 }
 
 */
- (void)chx_animation_alertPop;
/**
 动画消失
 
 常常配合使用：
 CGFloat duration = 0.15;
 [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
    self.tmpAnimView.alpha = 0;
    self.shadowView.alpha = 0;
 } completion:nil];
 
 [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    self.tmpAnimView.transform = CGAffineTransformMakeScale(0.4, 0.4);
 } completion:^(BOOL finished) {
    self.tmpAnimView.transform = CGAffineTransformMakeScale(1, 1);
    [self.tmpAnimView removeFromSuperview];
    [self.shadowView removeFromSuperview];
 }];
 
 */
- (void)chx_animation_alertDismiss;


@end
