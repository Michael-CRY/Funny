//
//  BSJHViewController.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/15.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSJHViewController.h"
#import "BSRecommendTagsViewController.h"
#import "BSTopicViewController.h"

@interface BSJHViewController ()<UIScrollViewDelegate>

/** 标签栏底部红色指示器 */
@property (weak, nonatomic) UIView *indicatorView;

/** 当前选中的按钮 */
@property (weak, nonatomic) UIButton *selectedButton;

/** 顶部所有标签 */
@property (weak, nonatomic) UIView *titlesView;

/** 底部的所有内容 */
@property (weak, nonatomic) UIScrollView *contentView;

@end

@implementation BSJHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置顶部的标签栏
    [self setupTitleView];
    
    //底部的scrollView
    [self setupContentView];
}

/**
 *  初始化子控制器
 */
- (void)setupChildVces{
    
    BSTopicViewController *all = [[BSTopicViewController alloc] init];
    all.title = @"全部";
    all.type = BSTopicTypeAll;
    [self addChildViewController:all];
    BSTopicViewController *video = [[BSTopicViewController alloc] init];
    video.title = @"视频";
    video.type = BSTopicTypeVideo;
    [self addChildViewController:video];
    BSTopicViewController *voice = [[BSTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = BSTopicTypeVoice;
    [self addChildViewController:voice];
    BSTopicViewController *picture = [[BSTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = BSTopicTypePicture;
    [self addChildViewController:picture];
    BSTopicViewController *word = [[BSTopicViewController alloc] init];
    word.title = @"段子";
    word.type = BSTopicTypeWord;
    [self addChildViewController:word];
    
    
}

/**
 *  设置顶部的标签栏
 */
- (void)setupTitleView {
    
    //标签栏整体
    UIView *titleView = [[UIView alloc] init];
//    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
//    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.width = self.view.width;
    titleView.height = BSTitlesViewH;
    titleView.y = BSTitlesViewY;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    //内部子标签
    CGFloat width = titleView.width / self.childViewControllers.count;
    CGFloat height = titleView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
//        [button layoutIfNeeded]; //强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        //默认选中第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            //让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titleView addSubview:indicatorView];
    
}

- (void)titleClick:(UIButton *)button {
    
    //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset  animated:YES];
    
}

/**
 *  底部的scrollView
 */
- (void)setupContentView {
    
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 *  设置导航栏
 */
- (void)setupNav {
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

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; //控制器view的Y值默认为20
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
    
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
