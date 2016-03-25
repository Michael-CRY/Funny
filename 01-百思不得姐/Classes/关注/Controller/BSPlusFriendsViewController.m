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

/** 请求参数 */
@property (nonatomic, strong)NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic, strong)AFHTTPSessionManager *manager;

@end

@implementation BSPlusFriendsViewController

static NSString *const BJplusFriendId = @"plusFriendCell";
static NSString *const BJuserFriendId = @"user";

- (AFHTTPSessionManager *)manager{
    if (!_manager){
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件初始化
    [self setupTableView];
    
    //刷新控件
    [self setupRefresh];
    
    //加载左侧类别数据
    [self loadCategories];
    
}

/**
 *  加载左侧类别数据
 */
- (void)loadCategories {
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的JSON数据
        self.categories = [BSplusModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.plusFriendTableView reloadData];
        
        //默认选中首行
        [self.plusFriendTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
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
 *  添加刷新控件
 */
- (void)setupRefresh{
    
    //下拉刷新
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //上拉加载
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

/**
 *  下拉刷新
 */
- (void)loadNewUsers{
    BSplusModel *m = BSSelectedCategory;
    
    //设置当前页码为1
    m.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"subscribe";
    param[@"category_id"] = @(m.id);
    param[@"page"] = @(m.currentPage);
    self.params = param;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组 -> 模型数组
        NSArray *users = [BSUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除旧数据
        [m.users removeAllObjects];
        
        //添加到当前类别对应的数组中
        [m.users addObjectsFromArray:users];
        
        //保存总数
        m.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if (self.params != param) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != param) return;
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}
/**
 *  上拉加载
 */
- (void)loadMoreUsers{
    
    BSplusModel *category = BSSelectedCategory;
    
    //发送请求给服务器，加载右侧数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"a"] = @"list";
    param[@"c"] = @"subscribe";
    param[@"category_id"] = @(category.id);
    param[@"page"] = @(++category.currentPage);
    self.params = param;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组 -> 模型数组
        NSArray *users = [BSUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的数组中
        [category.users addObjectsFromArray:users];
        
        if (self.params != param) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != param) return;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  时刻检测footer的状态
 */
- (void)checkFooterState{
    BSplusModel *category = BSSelectedCategory;
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    //让底部控件结束刷新
    if (category.users.count == category.total) { //全部数据加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{ //还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark -- <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //左边类别表格
    if (tableView == self.plusFriendTableView) return self.categories.count;
    
    //检测footer状态
    [self checkFooterState];
    
    //右边用户表格
    return [BSSelectedCategory users] .count;
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
    
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    BSplusModel *m = self.categories[indexPath.row];
    
    if (m.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    }else{
        //赶紧刷新数据，目的是：马上显示当前category的用户数据，不让用户看见上一个category的数据
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark -- 控制器的销毁
- (void)dealloc{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}


@end
