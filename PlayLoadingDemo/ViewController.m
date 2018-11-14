//
//  ViewController.m
//  PlayLoadingDemo
//
//  Created by sunyazhou on 2018/11/12.
//  Copyright © 2018 sunyazhou.com. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (nonatomic, strong) UIView *playLoadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init player status bar
    self.playLoadingView = [[UIView alloc]init];
    self.playLoadingView.backgroundColor = [UIColor whiteColor];
    [self.playLoadingView setHidden:YES];
    [self.view addSubview:self.playLoadingView];
    
    //make constraintes
    [self.playLoadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(1.0f); //宽 1 dp
        make.height.mas_equalTo(0.5f); //高 0.5 dp
    }];
    
    [self startLoadingPlayAnimation:YES];
    
    //模拟10秒后关闭
    [self performSelector:@selector(startLoadingPlayAnimation:) withObject:@(NO) afterDelay:10];
}

- (void)startLoadingPlayAnimation:(BOOL)isStart {
    if (isStart) {
        self.playLoadingView.backgroundColor = [UIColor whiteColor];
        self.playLoadingView.hidden = NO;
        [self.playLoadingView.layer removeAllAnimations];
        
        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
        animationGroup.duration = 0.5;
        animationGroup.beginTime = CACurrentMediaTime() + 0.5;
        animationGroup.repeatCount = MAXFLOAT;
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
        scaleAnimation.keyPath = @"transform.scale.x";
        scaleAnimation.fromValue = @(1.0f);
        scaleAnimation.toValue = @(1.0f * ScreenWidth);
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
        alphaAnimation.keyPath = @"opacity";
        alphaAnimation.fromValue = @(1.0f);
        alphaAnimation.toValue = @(0.5f);
        
        [animationGroup setAnimations:@[scaleAnimation, alphaAnimation]];
        [self.playLoadingView.layer addAnimation:animationGroup forKey:nil];
    } else {
        [self.playLoadingView.layer removeAllAnimations];
        self.playLoadingView.hidden = YES;
    }
}

@end
