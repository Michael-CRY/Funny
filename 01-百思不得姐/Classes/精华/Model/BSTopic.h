//
//  BSTopic.h
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/24.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTopic : NSObject

/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 头像 */
@property (copy, nonatomic) NSString *profile_image;
/** 发帖时间 */
@property (copy, nonatomic) NSString *created_at;
/** 文字内容 */
@property (copy, nonatomic) NSString *text;
/** 顶的数量 */
@property (assign, nonatomic) NSInteger ding;
/** 踩得数量 */
@property (assign, nonatomic) NSInteger cai;
/** 转发的数量 */
@property (assign, nonatomic) NSInteger repost;
/** 评论的数量 */
@property (assign, nonatomic) NSInteger comment;
/** 图片的宽度 */
@property (assign, nonatomic) CGFloat width;
/** 图片的高度 */
@property (assign, nonatomic) CGFloat height;
/** 小图片的URL */
@property (copy, nonatomic) NSString *small_image;
/** 大图片的URL */
@property (copy, nonatomic) NSString *middle_image;
/** 中图片的URL */
@property (copy, nonatomic) NSString *large_image;


/****** 额外的辅助属性 ******/

/** cell的高度 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;

@end
