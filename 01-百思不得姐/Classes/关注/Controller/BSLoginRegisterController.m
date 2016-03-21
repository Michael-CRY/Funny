//
//  BSLoginRegisterController.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/19.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSLoginRegisterController.h"

@interface BSLoginRegisterController ()

@property (strong, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/** 登录框距离控制器view左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;


@end

@implementation BSLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.bgView atIndex:0];
    
    /*
    //文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    //NSAttributedString带有属性的文字（富文本技术）
//    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    self.phoneField.attributedPlaceholder = placeholder;
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLoginRegister:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { //显示注册
        self.loginViewLeftMargin.constant = - self.view.width;
//        [sender setTitle:@"已有账号？" forState:UIControlStateNormal];
        sender.selected = YES;
    } else { //显示登录
        self.loginViewLeftMargin.constant = 0;
//        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];
}


/**
 *  让当前控制器对应的状态栏是白色的
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)backBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
