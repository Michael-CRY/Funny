//
//  UIBarButtonItem+BSExtension.h
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/16.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BSExtension)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action;

@end
