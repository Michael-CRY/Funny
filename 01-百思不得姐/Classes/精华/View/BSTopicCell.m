//
//  BSTopicCell.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/24.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSTopicCell.h"
#import "BSTopic.h"
#import <UIImageView+WebCache.h>

@interface BSTopicCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_Label;


@end

@implementation BSTopicCell

- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
}

- (void)setTopic:(BSTopic *)topic {
    
    _topic = topic;
    
    //设置头像
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //设置名字
    self.nameLabel.text = topic.name;
    
    //设置帖子的创建时间
    self.createLabel.text = topic.created_at;
    
    //设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    //设置帖子的文字内容
    self.text_Label.text = topic.text;
}

//- (void)testDate:(NSString *)create_time {
//    //日期格式化类
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    //设置日期格式
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    //当前时间
//    NSDate *now = [NSDate date];
//    //发帖时间
//    NSDate *create = [fmt dateFromString:create_time];
//    
////    //日历
////    NSCalendar *calender = [NSCalendar currentCalendar];
////    
////    //比较时间
////    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
////    NSDateComponents *cmps = [calender components:unit fromDate:create_time toDate:now options:0];
//    
//    //获得NSDate的每一个元素
////    NSInteger year = [calender component:NSCalendarUnitYear fromDate:now];
////    NSInteger month = [calender component:NSCalendarUnitMonth fromDate:now];
////    NSInteger day = [calender component:NSCalendarUnitDay fromDate:now];
////    NSDateComponents *cmps = [calender components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:now];
//    
//}

//- (void)testDate:(NSString *)create_time {
//    //当前时间
//    NSDate *now = [NSDate date];
//    //发帖时间 NSString -> NSDate
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    //设置日期格式
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *create = [fmt dateFromString:topic.create_time];
//    
//    NSTimeInterval delta = [now timeIntervalSinceDate:create];
//    BSLog(@"%f", delta);
//
//}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    
//    NSString *title = nil;
//    if (count == 0) {
//        title = placeholder;
//    } else if (count > 10000) {
//        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
//    } else {
//        title = [NSString stringWithFormat:@"%zd", count];
//    }
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = BSTopicCellMargin;
    frame.size.width -= 2 *frame.origin.x;
    frame.size.height -= BSTopicCellMargin;
    frame.origin.y += BSTopicCellMargin;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
