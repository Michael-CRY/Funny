//
//  BSplusModel.m
//  01-百思不得姐
//
//  Created by 柴闰严 on 16/3/17.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "BSplusModel.h"

@implementation BSplusModel

- (NSMutableArray *)users{
    if (!_users){
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
