//
//  BSTopicViewController.h
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/25.
//  Copyright © 2016年 KING. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>

typedef enum {
    BSTopicTypeAll = 1,
    BSTopicTypePicture = 10,
    BSTopicTypeWord = 29,
    BSTopicTypeVoice = 31,
    BSTopicTypeVideo = 41
} BSTopicType;

@interface BSTopicViewController : UITableViewController

/** 类型 */
@property (assign, nonatomic) BSTopicType type;

@end
