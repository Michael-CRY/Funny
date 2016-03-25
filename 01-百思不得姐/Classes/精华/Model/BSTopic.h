//
//  BSTopic.h
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/24.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
