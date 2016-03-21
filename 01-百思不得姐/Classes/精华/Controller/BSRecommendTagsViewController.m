//
//  BSRecommendTagsViewController.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/19.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "BSRecommendTag.h"
#import "BSRecommendTagCell.h"

@interface BSRecommendTagsViewController ()

/** 标签 */
@property (nonatomic, strong)NSArray *tags;

@end

static NSString *const BSTagsId = @"tag";

@implementation BSRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
     
    [self loadTags];
    
}

- (void)setupTableView{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:BSTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BSBackgroundColor;
}

- (void)loadTags{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.tags = [BSRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:BSTagsId];
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
