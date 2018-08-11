//
//  ViewController.m
//  ChXViewAnimationDemo
//
//  Created by Xu Chen on 2018/8/11.
//  Copyright © 2018年 xu.yzl. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ChXAnimation.h"
#import "UIColor+ChXRandom.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *animView;
@property (nonatomic, strong) UIView *tmpAnimView;
@property (nonatomic, strong) UIView *shadowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animView = [self createViewInParentView:self.view];
}

- (UIView *)createViewInParentView:(UIView *)parentView {
    UIView *animView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    animView.backgroundColor = UIColor.chx_randomColor;
    [parentView addSubview:animView];
    return animView;
}

// MARK: - 响应事件
/**
 一键还原
 */
- (IBAction)resetClicked:(id)sender {
    for (UIView *view in self.view.subviews) {
        if ([view isEqual:self.animView]) {
            [view removeFromSuperview];
            
            self.animView = [self createViewInParentView:self.view];
        }
    }
}

/**
 左右晃动
 */
- (IBAction)shakeClicked:(id)sender {
    [self.animView chx_animation_errorShake];
//    [self.animView chx_animation_errorShakeWithVigourOfShake:0.05];
}
/**
 平移
 */
- (IBAction)moveClicked:(id)sender {
    [self.animView chx_animation_moveTo:CGPointMake(50, 150)];
//    [self.animView chx_animation_moveTo:CGPointMake(50, 150) duration:1.0];
}
/**
 顺时针旋转
 */
- (IBAction)clockwiseRotationClicked:(id)sender {
    [self.animView chx_animation_rotationWithDuration:2.0 isRepeat:NO isClockwise:YES];
}
/**
 逆时针旋转
 */
- (IBAction)anticlockwiseRotationClicked:(id)sender {
    [self.animView chx_animation_rotationWithDuration:2.0 isRepeat:YES isClockwise:NO];
}
/**
 修改透明度
 */
- (IBAction)alphaClicked:(id)sender {
    [self.animView chx_animation_changeAlpha:0.3];
}
/**
 fade形式添加视图
 */
- (IBAction)fadeAddSubviewClicked:(id)sender {
    UIView *animView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    animView.backgroundColor = UIColor.chx_randomColor;
    [self.animView chx_animation_addSubViewWithFadeAnimation:animView];
}
/**
 弹窗pop动画
 */
- (IBAction)alertPop:(id)sender {
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    shadowView.backgroundColor = UIColor.blackColor;
    shadowView.alpha = 0.1;
    [self.view addSubview:shadowView];
    self.shadowView = shadowView;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertDismiss:)];
    [shadowView addGestureRecognizer:gesture];
    
    UIView *animView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    animView.backgroundColor = UIColor.chx_randomColor;
    animView.layer.masksToBounds = YES;
    animView.layer.cornerRadius = 10;
    self.tmpAnimView = animView;
    [self.view addSubview:animView];
    
    // 动画弹出
    [animView chx_animation_alertPop];
}
/**
 弹窗消失
 */
- (IBAction)alertDismiss:(id)sender {
    for (UIView *view in self.view.subviews) {
        if ([view isEqual:self.tmpAnimView]) {
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
            
        }
    }
}

@end
