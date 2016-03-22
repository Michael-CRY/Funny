//
//  BSJHViewController.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSJHViewController.h"
#import "BSRecommendTagsViewController.h"

@interface BSJHViewController ()

@end

@implementation BSJHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = BSBackgroundColor;
}

- (void)tagClick{
    BSRecommendTagsViewController *tags = [[BSRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
