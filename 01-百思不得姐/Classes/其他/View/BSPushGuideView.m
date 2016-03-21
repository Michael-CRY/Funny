//
//  BSPushGuideView.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/21.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSPushGuideView.h"

@implementation BSPushGuideView

+ (instancetype)guideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show{
    NSString *key = @"CFBundleShortVersionString";
    
    //获取当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获取沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        BSPushGuideView *pushGuide = [BSPushGuideView guideView];
        pushGuide.frame = window.bounds;
        [window addSubview:pushGuide];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)close {
    [self removeFromSuperview];
}
@end
