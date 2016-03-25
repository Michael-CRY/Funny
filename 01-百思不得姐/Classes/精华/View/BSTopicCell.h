//
//  BSTopicCell.h
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/24.
//  Copyright © 2016年 KING. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSTopic;

@interface BSTopicCell : UITableViewCell

/** 帖子数据 */
@property (strong, nonatomic) BSTopic *topic;

@end
