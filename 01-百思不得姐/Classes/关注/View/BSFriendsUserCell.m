//
//  BSFriendsUserCell.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/18.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSFriendsUserCell.h"
#import "BSUserModel.h"
#import <UIImageView+WebCache.h>

@interface BSFriendsUserCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *fansCountLabel;


@end

@implementation BSFriendsUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(BSUserModel *)user{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人", user.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@"%.1f万人", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
