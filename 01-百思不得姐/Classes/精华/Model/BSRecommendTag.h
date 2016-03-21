//
//  BSRecommendTag.h
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/19.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommendTag : NSObject

/** 图片 */
@property (nonatomic, copy)NSString *image_list;
/** 名字 */
@property (nonatomic, copy)NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign)NSInteger sub_number;

@end
