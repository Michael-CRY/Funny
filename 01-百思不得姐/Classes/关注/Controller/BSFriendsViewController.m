//
//  BSFriendsViewController.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSFriendsViewController.h"
#import "BSPlusFriendsViewController.h"
#import "BSLoginRegisterController.h"

@interface BSFriendsViewController ()

@end

@implementation BSFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    self.view.backgroundColor = BSBackgroundColor;
}

- (void)friendsClick{
    BSPlusFriendsViewController *plusVC = [[BSPlusFriendsViewController alloc] init];
    [self.navigationController pushViewController:plusVC animated:YES];
}

- (IBAction)loginRegister {
    BSLoginRegisterController *login = [[BSLoginRegisterController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
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
