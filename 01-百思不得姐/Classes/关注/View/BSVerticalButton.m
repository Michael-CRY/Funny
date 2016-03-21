//
//  BSVerticalButton.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/20.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSVerticalButton.h"

@implementation BSVerticalButton

- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
