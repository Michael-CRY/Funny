//
//  BSRecommendTagCell.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/19.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSRecommendTagCell.h"
#import "BSRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface BSRecommendTagCell ()

@property (strong, nonatomic) IBOutlet UIImageView *image_listImageView;
@property (strong, nonatomic) IBOutlet UILabel *theme_nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sub_numberLabel;

@end

@implementation BSRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendTag:(BSRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    
    [self.image_listImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.theme_nameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.sub_numberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame{
    
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
