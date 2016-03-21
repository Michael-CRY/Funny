//
//  BSTextField.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/20.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSTextField.h"
#import <objc/runtime.h>

static NSString * const BSPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation BSTextField

//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 10, 100, 25) withAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:self.font}];
//}


/**
 运行时(Runtime):
 * 苹果官方一套C语言库
 * 能做很多底层操作（比如访问隐藏的一些成员变量、成员方法）
 */

//+ (void)initialize
//{
//    unsigned int count = 0;
//    
//    //拷贝出所有的成员变量列表
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        //取出成员变量
////        Ivar ivar = *(ivars + i);
//        Ivar ivar = ivars[i];
//        
//        //打印成员变量名字
//        BSLog(@"%s", ivar_getName(ivar));
//    }
//    
//    //释放
//    free(ivars);
//}

- (void)awakeFromNib
{
//    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor whiteColor];
    
    //修改占位文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];
}

/**
 *  当前文本框聚焦时会被调用
 */
- (BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:BSPlaceholderColorKeyPath];
    
    return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时会被调用
 */
- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:BSPlaceholderColorKeyPath];
    
    return [super resignFirstResponder];
}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor{
//    _placeholderColor = placeholderColor;
//    
//    //修改占位文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:BSPlaceholderColorKeyPath];
//}


//- (void)setHighlighted:(BOOL)highlighted{
//    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
//}


@end
