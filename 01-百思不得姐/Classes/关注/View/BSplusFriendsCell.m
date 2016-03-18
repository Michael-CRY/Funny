//
//  BSplusFriendsCell.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/17.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSplusFriendsCell.h"
#import "BSplusModel.h"

@interface BSplusFriendsCell ()

/** 选中时显示的指示器控件 */
@property (strong, nonatomic) IBOutlet UIView *selectedView;

@end

@implementation BSplusFriendsCell

- (void)awakeFromNib {
    
    self.backgroundColor = backgroundColor(244, 244, 244);
    self.selectedView.backgroundColor = backgroundColor(219, 21, 26);
    
    /*
    //当cell的selection为None时，即使cell被选中了，内部的子控件也不会进入高亮状态
//    self.textLabel.textColor = backgroundColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = backgroundColor(219, 21, 26);
//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bg;
     */
}

- (void)setCategory:(BSplusModel *)category{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //重新调整内部textLable的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 3;
    
}

/**
 *  可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    self.selectedView.hidden = !selected;
    self.textLabel.textColor = selected?self.selectedView.backgroundColor:backgroundColor(78, 78, 78);
}


@end
