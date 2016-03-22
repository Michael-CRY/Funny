//
//  BSTabBar.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSTabBar.h"

@interface BSTabBar ()

@property (nonatomic, strong)UIButton *publishButton;

@end

@implementation BSTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置tabBar背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置发布按钮的frame
    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
//    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(width / 2, height / 2);
    
    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        //计算按钮的X值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):(index));
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //增加索引
        index ++;
    }
}

@end
