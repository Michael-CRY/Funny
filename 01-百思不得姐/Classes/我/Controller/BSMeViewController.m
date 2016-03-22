//
//  BSMeViewController.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSMeViewController.h"

@interface BSMeViewController ()

@end

@implementation BSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    //设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *nightMoonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem,nightMoonItem];
    self.view.backgroundColor = BSBackgroundColor;
}

- (void)settingClick{
    BSLogFunc;
}

- (void)nightModeClick{
    BSLogFunc;
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
