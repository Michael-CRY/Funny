//
//  BSPlusFriendsViewController.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/17.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSPlusFriendsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "BSplusFriendsCell.h"
#import <MJExtension.h>
#import "BSplusModel.h"
#import "BSFriendsUserCell.h"
#import "BSUserModel.h"
#import <MJRefresh.h>

#define BSSelectedCategory self.categories[self.plusFriendTableView.indexPathForSelectedRow.row]

@interface BSPlusFriendsViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 左边的类别数据 */
@property (nonatomic, strong)NSArray *categories;
/** 左边的类别表格 */
@property (strong, nonatomic) IBOutlet UITableView *plusFriendTableView;
@property (strong, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation BSPlusFriendsViewController

static NSString *const BJplusFriendId = @"plusFriendCell";
static NSString *const BJuserFriendId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件初始化
    [self setupTableView];
    
    //刷新控件
    [self setupRefresh];
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的JSON数据
        self.categories = [BSplusModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.plusFriendTableView reloadData];
        
        //默认选中首行
        [self.plusFriendTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
    }];
}

/**
 *  控件初始化
 */
- (void)setupTableView{
    //注册
    [self.plusFriendTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSplusFriendsCell class]) bundle:nil] forCellReuseIdentifier:BJplusFriendId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSFriendsUserCell class]) bundle:nil] forCellReuseIdentifier:BJuserFriendId];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.plusFriendTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.plusFriendTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    //标题
    self.title = @"推荐关注";
    //背景色
    self.view.backgroundColor = BSBackgroundColor;
}

/**
 *  刷新控件
 */
- (void)setupRefresh{
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

/**
 *  加载用户数据
 */
- (void)loadMoreUsers{
    
    BSplusModel *category = BSSelectedCategory;
    
    //发送请求给服务器，加载右侧数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"subscribe";
    param[@"category_id"] = @(category.id);
    param[@"page"] = @(++category.currentPage);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组 -> 模型数组
        NSArray *users = [BSUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的数组中
        [category.users addObjectsFromArray:users];
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        if (category.users.count == category.total) { //全部加载完毕
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.plusFriendTableView) { //左边类别表格
        return self.categories.count;
    }else{ //右边用户表格
        NSInteger count = [BSSelectedCategory users].count;
        //每次刷新右边数据时，都控制footer显示或者隐藏
        self.userTableView.mj_footer.hidden = (count == 0);
        
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.plusFriendTableView) { //左边类别表格
        BSplusFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:BJplusFriendId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{ //右边用户表格
        BSFriendsUserCell *cell = [tableView dequeueReusableCellWithIdentifier:BJuserFriendId];
        cell.user = [BSSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark -- <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BSplusModel *m = self.categories[indexPath.row];
    
    [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    
    if (m.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    }else{
        //赶紧刷新数据，目的是：马上显示当前category的用户数据，不让用户看见上一个category的数据
        [self.userTableView reloadData];
        
        //设置当前页码为1
        m.currentPage = 1;
        
        //发送请求给服务器，加载右侧数据
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"a"] = @"list";
        param[@"c"] = @"subscribe";
        param[@"category_id"] = @(m.id);
        param[@"page"] = @(m.currentPage);
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //字典数组 -> 模型数组
            NSArray *users = [BSUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            //添加到当前类别对应的数组中
            [m.users addObjectsFromArray:users];
            
            //保存总数
            m.total = [responseObject[@"total"] integerValue];
            
            //刷新右边表格
            [self.userTableView reloadData];
            
            if (m.users.count == m.total) { //全部加载完毕
                [self.userTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}




@end
