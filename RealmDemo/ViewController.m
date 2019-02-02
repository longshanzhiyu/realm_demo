//
//  ViewController.m
//  RealmDemo
//
//  Created by njw on 2019/2/2.
//  Copyright © 2019 njw. All rights reserved.
//

#import "ViewController.h"
#import "Post.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    Post *post = [[Post alloc] initWithValue:@{@"title":@"untitled"}];
//    User *user = [[User alloc] init];
//    post.author = user;
//
//    RLMRealm *r = [RLMRealm defaultRealm];
//    [r transactionWithBlock:^{
//        [r addObject:post];
//        [r addObject:user];
//
//        NSLog(@"%@", user.posts);
//    }];
    
    //数据的增删改查
    
    Post *post = [[Post alloc] init];
    post.title = @"untitled";
    post.identifer = [[NSDate date] description];
    
    RLMRealm *r = [RLMRealm defaultRealm];
    [r transactionWithBlock:^{
        //写入事务
        [r addObject:post];
    }];
    
    //删
    [r transactionWithBlock:^{
//        [r deleteObject:post];
//        r deleteObjects:<#(nonnull id<NSFastEnumeration>)#>
//        [r deleteAllObjects]; //注意： 数据库清空后，数据库文件并不会减小
    }];
    
    //改 (注意： 一个对象在没有写入数据库时，可以在外部修改，如果已经写入数据库，必须在此block中修改 才有效)
    [r transactionWithBlock:^{
        post.timestamp = [NSDate date];
    }];
    
    //查
    RLMResults *results = [Post objectsWhere:@"title == %@", @"untitled"];
    Post *postBeFound = [results firstObject];
    
    [r transactionWithBlock:^{
        post.title = @"Test for Change"; //自动更新
    }];
    
    NSLog(@"%@", postBeFound);
    
    Post *postNew = [[Post alloc] init];
    postNew.title = @"newTitle";
    postNew.identifer = @"1";
    postNew.timestamp = [NSDate date];
    [r transactionWithBlock:^{
        [r addOrUpdateObject:post];
    }];
    
    //批量修改
    RLMResults *allPosts = [Post allObjects];
    
    [r transactionWithBlock:^{
        [allPosts setValue:[NSDate date] forKey:@"timestamp"];
    }];
}


@end
